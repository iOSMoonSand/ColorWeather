//
//  CurrentWeatherView.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/15/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

// TODO: Replace hard-coded numbers with constants.
// TODO: Use localized strings.

private struct Constants {
    static let noDataDefault = "--"
    static let lowTempSymbol = "L"
    static let highTempSymbol = "H"
    static let sunset = "SUNSET"
    static let sunrise = "SUNRISE"
}

struct CurrentWeatherView: View {
    
    // MARK: - Stateful Properties
    
    // MARK: Public
    @EnvironmentObject var userSettings: UserSettings
    @ObservedObject var currentWeatherViewModel = CurrentWeatherViewModel()
    
    // MARK: Private
    @State private var shouldShowErrorAlert = false
    
    // MARK: - Stateless Properties
    
    // MARK: Public
    var city: String
    
    // MARK: - View Body
    var body: some View {
        
        var firstForecastObject = TriHourlyForecastDataModel()
        var secondForecastObject = TriHourlyForecastDataModel()
        var thirdForecastObject = TriHourlyForecastDataModel()
        
        if !currentWeatherViewModel.triHourlyForecastDataModels.isEmpty {
            firstForecastObject = currentWeatherViewModel.triHourlyForecastDataModels[0]
            secondForecastObject = currentWeatherViewModel.triHourlyForecastDataModels[1]
            thirdForecastObject = currentWeatherViewModel.triHourlyForecastDataModels[2]
        }
        
        let unit: UnitTemperature = userSettings.unitsInFahrenheit ? .fahrenheit : .celsius
        let currentTemperature = " " + Utilities.convert(temperature: currentWeatherViewModel.weatherData.temp,
                                                         from: .kelvin,
                                                         to: unit)
        let currentLow = Utilities.convert(temperature: currentWeatherViewModel.weatherData.tempMin,
                                           from: .kelvin,
                                           to: unit)
        let currentHigh = Utilities.convert(temperature: currentWeatherViewModel.weatherData.tempMax,
                                            from: .kelvin,
                                            to: unit)
        let firstForecastObjectLow = Utilities.convert(temperature: firstForecastObject.tempMin,
                                                       from: .kelvin,
                                                       to: unit)
        let firstForecastObjectHigh = Utilities.convert(temperature: firstForecastObject.tempMax,
                                                        from: .kelvin,
                                                        to: unit)
        let secondForecastObjectLow = Utilities.convert(temperature: secondForecastObject.tempMin,
                                                        from: .kelvin,
                                                        to: unit)
        let secondForecastObjectHigh = Utilities.convert(temperature: secondForecastObject.tempMax,
                                                         from: .kelvin,
                                                         to: unit)
        let thirdForecastObjectLow = Utilities.convert(temperature: thirdForecastObject.tempMin,
                                                       from: .kelvin,
                                                       to: unit)
        let thirdForecastObjectHigh = Utilities.convert(temperature: thirdForecastObject.tempMax,
                                                        from: .kelvin,
                                                        to: unit)
        
        let index = city.firstIndex(of: ",") ?? city.endIndex
        let citySubstring = city[..<index]
        let cityString = String(citySubstring)
        
        return ZStack {
            
            DynamicBackgroundColor(id: currentWeatherViewModel.weatherData.icon)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { container in
                
                VStack {
                    
                    Spacer()
                        .frame(width: 0,
                               height: 30,
                               alignment: .center)
                    
                    
                    Group {
                        Text(cityString)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .shadow(radius: 3)
                        
                        Text(self.currentWeatherViewModel.weatherData.description?.firstCapitalized ?? Constants.noDataDefault)
                            .foregroundColor(Color.white)
                            .shadow(radius: 3)
                    }
                    
                    Spacer()
                    if self.currentWeatherViewModel.weatherData.icon != nil {
                        Image(self.currentWeatherViewModel.weatherData.icon!)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 250,
                                   height: 250,
                                   alignment: .center)
                    } else {
                        Text("Retrieving weather data.")
                            .italic()
                            .foregroundColor(Color.white)
                    }
                    
                    Spacer()
                    
                    VStack {
                        
                        Text(currentTemperature)
                            .font(.system(size: 100))
                            .fontWeight(.ultraLight)
                            .foregroundColor(ColorConstants.Text.darkGray)
                        
                        Spacer()
                            .frame(width: 0,
                                   height: 20,
                                   alignment: .center)
                        
                        HStack {
                            
                            VStack(alignment: .trailing) {
                                
                                HStack(alignment: .firstTextBaseline) {
                                    
                                    Text(Constants.lowTempSymbol)
                                        .font(.system(size: 20))
                                        .fontWeight(.thin)
                                        .foregroundColor(ColorConstants.Text.darkGray)
                                    
                                    Text(currentLow)
                                        .font(.system(size: 30))
                                        .foregroundColor(ColorConstants.Text.darkGray)
                                }
                                
                                Spacer()
                                    .frame(width: 0,
                                           height: 15,
                                           alignment: .center)
                                
                                Text(Constants.sunrise)
                                    .font(.system(size: 16))
                                    .fontWeight(.thin)
                                    .foregroundColor(ColorConstants.Text.darkGray)
                                
                                Text("\(self.currentWeatherViewModel.weatherData.sunrise ?? Constants.noDataDefault)")
                                    .font(.system(size: 24))
                                    .foregroundColor(ColorConstants.Text.darkGray)
                            }
                            
                            Spacer()
                                .frame(width: 50,
                                       height: 0,
                                       alignment: .center)
                            
                            VStack(alignment: .leading) {
                                HStack(alignment: .firstTextBaseline) {
                                    Text(Constants.highTempSymbol)
                                        .font(.system(size: 20))
                                        .fontWeight(.thin)
                                        .foregroundColor(ColorConstants.Text.darkGray)
                                    
                                    Text(currentHigh)
                                        .font(.system(size: 30))
                                        .foregroundColor(ColorConstants.Text.darkGray)
                                }
                                
                                Spacer()
                                    .frame(width: 0,
                                           height: 15,
                                           alignment: .center)
                                
                                Text(Constants.sunset)
                                    .font(.system(size: 16))
                                    .fontWeight(.thin)
                                    .foregroundColor(ColorConstants.Text.darkGray)
                                
                                Text("\(self.currentWeatherViewModel.weatherData.sunset ?? Constants.noDataDefault)")
                                    .font(.system(size: 24))
                                    .foregroundColor(ColorConstants.Text.darkGray)
                            }
                        }
                        
                        Spacer()
                            .frame(width: 0,
                                   height: 30,
                                   alignment: .center)
                        
                        if !self.currentWeatherViewModel.triHourlyForecastDataModels.isEmpty {
                            Group {
                                Divider()
                                HStack(spacing: 16) {
                                    Text("\(firstForecastObject.forecastTime ?? Constants.noDataDefault)")
                                        .foregroundColor(ColorConstants.Text.darkGray)
                                    
                                    if firstForecastObject.icon != nil {
                                        Image(firstForecastObject.icon!)
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 30,
                                                   height: 30,
                                                   alignment: .center)
                                    } else {
                                        Text(Constants.noDataDefault)
                                            .foregroundColor(ColorConstants.Text.darkGray)
                                    }
                                    
                                    HStack {
                                        HStack(spacing: 3) {
                                            Text(Constants.lowTempSymbol)
                                                .foregroundColor(ColorConstants.Text.darkGray)
                                            Text(firstForecastObjectLow)
                                                .foregroundColor(ColorConstants.Text.darkGray)
                                        }
                                        HStack(spacing: 3) {
                                            Text(Constants.highTempSymbol)
                                                .foregroundColor(ColorConstants.Text.darkGray)
                                            Text(firstForecastObjectHigh)
                                                .foregroundColor(ColorConstants.Text.darkGray)
                                        }
                                    }
                                }
                                
                                Divider()
                                HStack(spacing: 16) {
                                    Text("\(secondForecastObject.forecastTime ?? Constants.noDataDefault)")
                                        .foregroundColor(ColorConstants.Text.darkGray)
                                    
                                    if secondForecastObject.icon != nil {
                                        Image(secondForecastObject.icon!)
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 30,
                                                   height: 30,
                                                   alignment: .center)
                                    } else {
                                        Text(Constants.noDataDefault)
                                            .foregroundColor(ColorConstants.Text.darkGray)
                                    }
                                    
                                    HStack {
                                        HStack(spacing: 3) {
                                            Text(Constants.lowTempSymbol)
                                                .foregroundColor(ColorConstants.Text.darkGray)
                                            Text(secondForecastObjectLow)
                                                .foregroundColor(ColorConstants.Text.darkGray)
                                        }
                                        HStack(spacing: 3) {
                                            Text(Constants.highTempSymbol)
                                                .foregroundColor(ColorConstants.Text.darkGray)
                                            Text(secondForecastObjectHigh)
                                                .foregroundColor(ColorConstants.Text.darkGray)
                                        }
                                    }
                                }
                                Divider()
                                HStack(spacing: 16) {
                                    Text("\(thirdForecastObject.forecastTime ?? Constants.noDataDefault)")
                                        .foregroundColor(ColorConstants.Text.darkGray)
                                    
                                    if thirdForecastObject.icon != nil {
                                        Image(thirdForecastObject.icon!)
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 30,
                                                   height: 30,
                                                   alignment: .center)
                                    } else {
                                        Text(Constants.noDataDefault)
                                            .foregroundColor(ColorConstants.Text.darkGray)
                                    }
                                    
                                    HStack {
                                        HStack(spacing: 3) {
                                            Text(Constants.lowTempSymbol)
                                                .foregroundColor(ColorConstants.Text.darkGray)
                                            Text(thirdForecastObjectLow)
                                                .foregroundColor(ColorConstants.Text.darkGray)
                                        }
                                        HStack(spacing: 3) {
                                            Text(Constants.highTempSymbol)
                                                .foregroundColor(ColorConstants.Text.darkGray)
                                            Text(thirdForecastObjectHigh)
                                                .foregroundColor(ColorConstants.Text.darkGray)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .frame(width: container.size.width - 40, height: container.size.height * 0.52, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 3)
                    .opacity(0.5)
                    
                    Spacer()
                        .frame(width: 0,
                               height: 20,
                               alignment: .center)
                    
                }
                .alert(isPresented: self.$shouldShowErrorAlert) {
                    // TODO: Clean up test code.
                    Alert(title: Text("Oops!"),
                          message: Text("We're having some trouble retrieving your data, please try again later."),
                          dismissButton: .default(Text("OK")))
                }
            }// GeometryReader
        } // ZStack
        
    } // body
    
    
    /// Attempts to update the Current Weather and 3 Hour Forecast data from the Open Weather Map API.
    /// The API updates it's data no more than once every 10 min so we refresh the
    /// data once it's more than 10 min old. All times are calculated in UTC.
    func updateViewData() {
        
        let currentTime: TimeInterval = Date().timeIntervalSince1970
        let baseTime = currentWeatherViewModel.timeOfLatestCurrentWeatherData
        let buffer = UIConstants.CurrentWeather.refreshTimeInterval
        
        guard
            Date.exceeds(baseTime: baseTime,
                         buffer: buffer,
                         currentTime: currentTime)
            else {
                return
        }
        
        self.currentWeatherViewModel.requestTriHourlyForecastData(with: self.city) { successRetrievingCoordinates, webRequestError in
            
            // TODO: Need to differentiate alerts shown based on error type.
            if !successRetrievingCoordinates {
                self.shouldShowErrorAlert = true
                return
            }
            
            switch webRequestError {
            case .some(let error) where error == RequestError.notConnectedToInternet:
                //TODO: Display notConnectedToInternet error message in UI using `error.errorDescription` on the main thread.
                self.shouldShowErrorAlert = true
                return
                
            case .some(_):
                //TODO: Display "trouble getting data" error message in UI using `error.errorDescription` on the main thread.
                self.shouldShowErrorAlert = true
                return
                
            case .none:
                self.shouldShowErrorAlert = false
            }
        }
        
        self.currentWeatherViewModel.requestWeatherData(with: self.city) { successRetrievingCoordinates, webRequestError in
            
            // TODO: Need to differentiate alerts shown based on error type.
            if !successRetrievingCoordinates {
                self.shouldShowErrorAlert = true
                return
            }
            
            switch webRequestError {
            case .some(let error) where error == RequestError.notConnectedToInternet:
                //TODO: Display notConnectedToInternet error message in UI using `error.errorDescription` on the main thread.
                self.shouldShowErrorAlert = true
                return
                
            case .some(_):
                //TODO: Display "trouble getting data" error message in UI using `error.errorDescription` on the main thread.
                self.shouldShowErrorAlert = true
                return
                
            case .none:
                self.shouldShowErrorAlert = false
            }
        }
    }
}

struct CurrentWeatherView_Preview: PreviewProvider {
    
    static var previews: some View {
        CurrentWeatherView(city: "San Francisco")
            .background(ColorConstants.Sky.Day.clear)
            .edgesIgnoringSafeArea(.all)
    }
}
