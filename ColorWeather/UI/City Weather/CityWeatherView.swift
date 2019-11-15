//
//  CityWeatherView.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/15/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

struct CityWeatherView: View {
    
    // MARK: - Stateful Properties
    
    // MARK: Public
    // TODO: May want to rename the view model in the future to something more specific.
    @ObservedObject var cityWeatherViewModel = CityWeatherViewModel()
    
    // MARK: Private
    @State private var shouldShowAlert = false
    
    // MARK: - Stateless Properties
    
    // MARK: Public
    var city: String
    
    // MARK: - View Body
    var body: some View {
        
        VStack {
            // TODO: Clean up test code.
            Text(city)
                .font(.title)
            Text(String(format: "%.2f", cityWeatherViewModel.weatherData.temp ?? 0.0))
            Text(cityWeatherViewModel.weatherData.description ?? "No Data.")
            HStack {
                Text("Min: \(String(format: "%.2f", cityWeatherViewModel.weatherData.tempMin ?? 0.0))")
                Text("Max: \(String(format: "%.2f", cityWeatherViewModel.weatherData.tempMax ?? 0.0))")
            }
        }
        .onAppear {
            self.cityWeatherViewModel.requestWeatherData(with: self.city) { successRetrievingCoordinates, webRequestError in
                
                // TODO: Need to differentiate alerts shown based on error type.
                if !successRetrievingCoordinates {
                    self.shouldShowAlert = true
                    return
                }
                
                switch webRequestError {
                case .some(let error) where error == RequestError.notConnectedToInternet:
                    //TODO: Display notConnectedToInternet error message in UI using `error.errorDescription` on the main thread.
                    self.shouldShowAlert = true
                    return
                    
                case .some(_):
                    //TODO: Display "trouble getting data" error message in UI using `error.errorDescription` on the main thread.
                    self.shouldShowAlert = true
                    return
                    
                case .none:
                    self.shouldShowAlert = false
                }
            }
        }
        .alert(isPresented: $shouldShowAlert) {
            // TODO: Clean up test code.
            Alert(title: Text("Oops!"), message: Text("We're having some trouble retrieving your data, please try again later."), dismissButton: .default(Text("OK")))
        }
    }
}
