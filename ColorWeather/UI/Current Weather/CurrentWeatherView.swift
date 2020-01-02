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
        let currentTemperature = Utilities.convert(temperature: currentWeatherViewModel.weatherData.temp ?? 0,
                                                   from: .kelvin,
                                                   to: unit)
        let currentLow = Utilities.convert(temperature: currentWeatherViewModel.weatherData.tempMin ?? 0,
                                           from: .kelvin,
                                           to: unit)
        let currentHigh = Utilities.convert(temperature: currentWeatherViewModel.weatherData.tempMax ?? 0,
                                            from: .kelvin,
                                            to: unit)
        let firstForecastObjectLow = Utilities.convert(temperature: firstForecastObject.tempMin ?? 0,
        from: .kelvin,
        to: unit)
        let firstForecastObjectHigh = Utilities.convert(temperature: firstForecastObject.tempMax ?? 0,
        from: .kelvin,
        to: unit)
        let secondForecastObjectLow = Utilities.convert(temperature: secondForecastObject.tempMin ?? 0,
        from: .kelvin,
        to: unit)
        let secondForecastObjectHigh = Utilities.convert(temperature: secondForecastObject.tempMax ?? 0,
        from: .kelvin,
        to: unit)
        let thirdForecastObjectLow = Utilities.convert(temperature: thirdForecastObject.tempMin ?? 0,
        from: .kelvin,
        to: unit)
        let thirdForecastObjectHigh = Utilities.convert(temperature: thirdForecastObject.tempMax ?? 0,
        from: .kelvin,
        to: unit)
        
        let geometryReader = GeometryReader { container in
            
            VStack {
                
                Spacer()
                    .frame(width: 0,
                           height: 30,
                           alignment: .center)
                
                
                Group {
                    Text(self.city)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .shadow(radius: 3)
                    
                    Text(self.currentWeatherViewModel.weatherData.description?.firstCapitalized ?? Constants.noDataDefault)
                        .foregroundColor(Color.white)
                        .shadow(radius: 3)
                }
                
                Spacer()
                
                // TODO: Load image dynamically.
                Image("cloudy")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 150,
                           height: 150,
                           alignment: .center)
                
                Spacer()
                
                VStack {
                    
                    Text(currentTemperature)
                        .font(.system(size: 100))
                        .fontWeight(.ultraLight)
                        .foregroundColor(Color.gray)
                    
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
                                    .foregroundColor(Color.gray)
                                
                                Text(currentLow)
                                    .font(.system(size: 30))
                                    .foregroundColor(Color.gray)
                            }
                            
                            Spacer()
                                .frame(width: 0,
                                       height: 15,
                                       alignment: .center)
                            
                            Text(Constants.sunrise)
                                .font(.system(size: 16))
                                .fontWeight(.thin)
                                .foregroundColor(Color.gray)
                            
                            Text("\(self.currentWeatherViewModel.weatherData.sunrise ?? Constants.noDataDefault)")
                                .font(.system(size: 24))
                                .foregroundColor(Color.gray)
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
                                    .foregroundColor(Color.gray)
                                
                                Text(currentHigh)
                                    .font(.system(size: 30))
                                    .foregroundColor(Color.gray)
                            }
                            
                            Spacer()
                                .frame(width: 0,
                                       height: 15,
                                       alignment: .center)
                            
                            Text(Constants.sunset)
                                .font(.system(size: 16))
                                .fontWeight(.thin)
                                .foregroundColor(Color.gray)
                            
                            // TODO: Use actual server data.
                            Text("\(self.currentWeatherViewModel.weatherData.sunset ?? Constants.noDataDefault)")
                                .font(.system(size: 24))
                                .foregroundColor(Color.gray)
                        }
                    }
                    
                    Spacer()
                        .frame(width: 0,
                               height: 30,
                               alignment: .center)
                    
                    // TODO filter server calls
                    if !self.currentWeatherViewModel.triHourlyForecastDataModels.isEmpty {
                        Group {
                            Divider()
                            HStack(spacing: 16) {
                                Text("\(firstForecastObject.forecastTime ?? Constants.noDataDefault)")
                                    .foregroundColor(Color.gray)
                                Text("\(firstForecastObject.icon!)")
                                    .foregroundColor(Color.gray)
                                HStack {
                                    HStack(spacing: 3) {
                                        Text(Constants.lowTempSymbol)
                                            .foregroundColor(Color.gray)
                                        Text(firstForecastObjectLow)
                                            .foregroundColor(Color.gray)
                                    }
                                    HStack(spacing: 3) {
                                        Text(Constants.highTempSymbol)
                                            .foregroundColor(Color.gray)
                                        Text(firstForecastObjectHigh)
                                            .foregroundColor(Color.gray)
                                    }
                                }
                            }
                            
                            Divider()
                            HStack(spacing: 16) {
                                Text("\(secondForecastObject.forecastTime ?? "--")")
                                    .foregroundColor(Color.gray)
                                Text("\(secondForecastObject.icon!)")
                                    .foregroundColor(Color.gray)
                                HStack {
                                    HStack(spacing: 3) {
                                        Text(Constants.lowTempSymbol)
                                            .foregroundColor(Color.gray)
                                        Text(secondForecastObjectLow)
                                            .foregroundColor(Color.gray)
                                    }
                                    HStack(spacing: 3) {
                                        Text(Constants.highTempSymbol)
                                            .foregroundColor(Color.gray)
                                        Text(secondForecastObjectHigh)
                                            .foregroundColor(Color.gray)
                                    }
                                }
                            }
                            Divider()
                            HStack(spacing: 16) {
                                Text("\(thirdForecastObject.forecastTime ?? "--")")
                                    .foregroundColor(Color.gray)
                                Text("\(thirdForecastObject.icon!)")
                                    .foregroundColor(Color.gray)
                                HStack {
                                    HStack(spacing: 3) {
                                        Text(Constants.lowTempSymbol)
                                            .foregroundColor(Color.gray)
                                        Text(thirdForecastObjectLow)
                                            .foregroundColor(Color.gray)
                                    }
                                    HStack(spacing: 3) {
                                        Text(Constants.highTempSymbol)
                                            .foregroundColor(Color.gray)
                                        Text(thirdForecastObjectHigh)
                                            .foregroundColor(Color.gray)
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(width: container.size.width - 40, height: container.size.height * 0.5, alignment: .center)
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius: 3)
                .opacity(0.9)
                
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
        } // GeometryReader
        return geometryReader
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
            .background(
                LinearGradient(gradient: Gradient(colors:
                    [ColorConstants.Sky.Day.clearGradientStart,
                     ColorConstants.Sky.Day.clearGradientEnd]),
                               startPoint: .top,
                               endPoint: .bottom)
        )
            .edgesIgnoringSafeArea(.all)
    }
}
