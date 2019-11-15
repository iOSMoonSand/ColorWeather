//
//  CityWeatherViewModel.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/15/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import CoreLocation
import os
import SwiftUI

class CityWeatherViewModel: ObservableObject {
    
    // MARK: - Stateful Properties
    
    // MARK: Public
    @Published var weatherData = WeatherDataModel()
    
    // MARK: - Stateless Properties
    
    // MARK: Private
    private let weatherDataService = WeatherDataRequestService()
    
    // MARK: - Public Methods
    
    
    /// Gets the geographic coordinates (latitude and longitude) from a user-readable address and initiates a request from the weather data service. Upon success, the method sets the view model's weatherData object which will subsequently be used to update the UI.
    /// - Parameter location: The user-readable address.
    /// - Parameter completion: Completion Handler returning a boolean indicating the success or failure of the geocoder and an error in case of a web request failure.
    func requestWeatherData(with location: String, completion: @escaping ((Bool, RequestError?) -> Void)) {
        
        getCoordinates(from: location) { coordinates in
            
            guard let coordinates = coordinates else {
                completion(false, nil)
                return
            }
            
            self.weatherDataService.requestWeatherData(from: coordinates) { weatherData, error in
                
                switch error {
                case .some(_):
                    completion(true, error)
                    
                case .none:
                    break
                }
                
                guard let data = weatherData else {
                    completion(true, RequestError.unknown)
                    return
                }
                DispatchQueue.main.async {
                    self.weatherData = data
                }
            }
        }
    }
    
    // MARK: - Public Methods
    
    
    /// Returns the geographic coordinates (latitude and longitude) in a completion handler using CoreLocation's CLGeocoder.
    /// - Parameter location: The user-readable address.
    /// - Parameter completion: Completion handler returning the latitude and longitude from the user-readable address or an error.
    private func getCoordinates(from location: String, completion: @escaping ((LocationCoordinates?) -> Void)) {
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(location) { placeMarks, error in
            
            guard error == nil else {
                os_log(OSLogConstants.CLGeocoder.errorFailedToGetCoordinates, log: .clGeocoder, type: .error)
                completion(nil)
                return
            }
            
            guard let coordinates = placeMarks?.first?.location?.coordinate else {
                os_log(OSLogConstants.CLGeocoder.errorFailedToGetCoordinates, log: .clGeocoder, type: .error)
                completion(nil)
                return
            }
            completion(LocationCoordinates(coordinates.latitude, coordinates.longitude))
        }
    }
}
