//
//  CurrentWeatherView.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/15/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

// TODO: Replace hard-coded numbers and strings with constants.
// TODO: Use localized strings.

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
        
        let units: UnitTemperature = userSettings.unitsInFahrenheit ? .fahrenheit : .celsius
        let currentTemperature = " " + Utilities.convert(temperature: currentWeatherViewModel.weatherData.temp,
                                                         from: .kelvin,
                                                         to: units)
        let currentLow = Utilities.convert(temperature: currentWeatherViewModel.weatherData.tempMin,
                                           from: .kelvin,
                                           to: units)
        let currentHigh = Utilities.convert(temperature: currentWeatherViewModel.weatherData.tempMax,
                                            from: .kelvin,
                                            to: units)
        
        let index = city.firstIndex(of: ",") ?? city.endIndex
        let citySubstring = city[..<index]
        let cityString = String(citySubstring)
        
        return ZStack {
            
            DynamicBackgroundColor(id: currentWeatherViewModel.weatherData.icon)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Text(cityString)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .shadow(radius: 3)
                
                Text(self.currentWeatherViewModel.weatherData.description?.firstCapitalized ?? UIConstants.Shared.noDataDefault)
                    .foregroundColor(Color.white)
                    .shadow(radius: 3)
                
                if self.currentWeatherViewModel.weatherData.icon != nil {
                    Image(self.currentWeatherViewModel.weatherData.icon!)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 150,
                               height: 150,
                               alignment: .center)
                } else {
                    Text("Retrieving weather data.")
                        .italic()
                        .foregroundColor(Color.white)
                }
                if currentWeatherViewModel.didLoad {
                    VStack { // Details bubble.
                        
                        Text(currentTemperature)
                            .font(.system(size: 90))
                            .fontWeight(.ultraLight)
                            .foregroundColor(ColorConstants.Text.darkGray)
                        
                        HStack {
                            
                            VStack(alignment: .trailing) { // Low temp and sunrise.
                                
                                HStack(alignment: .firstTextBaseline) { // Low temp.
                                    
                                    Text(UIConstants.Shared.lowTempSymbol)
                                        .font(.system(size: 20))
                                        .fontWeight(.thin)
                                        .foregroundColor(ColorConstants.Text.darkGray)
                                    
                                    Text(currentLow)
                                        .font(.system(size: 30))
                                        .foregroundColor(ColorConstants.Text.darkGray)
                                }.padding([.bottom], 15)
                                
                                // Sunrise.
                                Text(UIConstants.Shared.sunrise)
                                    .font(.system(size: 16))
                                    .fontWeight(.thin)
                                    .foregroundColor(ColorConstants.Text.darkGray)
                                
                                Text("\(self.currentWeatherViewModel.weatherData.sunrise ?? UIConstants.Shared.noDataDefault)")
                                    .font(.system(size: 24))
                                    .foregroundColor(ColorConstants.Text.darkGray)
                            }
                            
                            Spacer()
                                .frame(width: 40,
                                       height: 0,
                                       alignment: .center)
                            
                            VStack(alignment: .leading) { // High temp and sunset.
                                
                                HStack(alignment: .firstTextBaseline) { // High temp.
                                    Text(UIConstants.Shared.highTempSymbol)
                                        .font(.system(size: 20))
                                        .fontWeight(.thin)
                                        .foregroundColor(ColorConstants.Text.darkGray)
                                    
                                    Text(currentHigh)
                                        .font(.system(size: 30))
                                        .foregroundColor(ColorConstants.Text.darkGray)
                                }.padding([.bottom], 15)
                                
                                Text(UIConstants.Shared.sunset)
                                    .font(.system(size: 16))
                                    .fontWeight(.thin)
                                    .foregroundColor(ColorConstants.Text.darkGray)
                                
                                Text("\(self.currentWeatherViewModel.weatherData.sunset ?? UIConstants.Shared.noDataDefault)")
                                    .font(.system(size: 24))
                                    .foregroundColor(ColorConstants.Text.darkGray)
                            }
                        }
                        
                        if !self.currentWeatherViewModel.triHourlyForecastDataModels.isEmpty {
                            ForecastView(dataModels: [
                                firstForecastObject,
                                secondForecastObject,
                                thirdForecastObject],
                                         units: units)
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 3)
                    .opacity(0.5)
                }
            }
            .padding([.leading, .trailing, .top, .bottom], 30)
            .alert(isPresented: self.$shouldShowErrorAlert) {
                // TODO: Clean up test code.
                Alert(title: Text("Oops!"),
                      message: Text("We're having some trouble retrieving your data, please try again later."),
                      dismissButton: .default(Text("OK")))
            }
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
