//
//  WeatherDataRequestService.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 10/15/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import Foundation
import os

final class WeatherDataRequestService {
    
    private let client = WebClient(baseURL: URL(string: WebClientConstants.baseURLString)!)
    
    func requestWeatherData(from coordinates: LocationCoordinates,
                        completion: @escaping ((WeatherDataModel?, RequestError?) -> Void)) {
        
        let parameters: JSONDictionary = [
            WebClientConstants.coordinatesKey.latitude: coordinates.latitude,
            WebClientConstants.coordinatesKey.longitude: coordinates.longitude,
            WebClientConstants.appIdKey: AppSecrets.openWeatherAPIKey
        ]
        
        client.request(with: WebClientConstants.weatherPath,
                       parameters: parameters,
                       completion: { dataDictionary, error in
                        
                        switch error {
                            
                        case .some(_):
                            //TODO: Display "trouble getting data" error message in UI using `error.errorDescription` on the main thread.
                            completion(nil, error)
                            
                        case .none:
                            break
                        }
                        
                        guard
                            let dataDictionary = dataDictionary,
                            let weatherArray = dataDictionary[WebClientConstants.weatherObjectKey] as? [JSONDictionary],
                            let weatherDictionary = weatherArray.first,
                            let weatherModel = WeatherModel(jsonDictionary: weatherDictionary),
                            let mainDictionary = dataDictionary[WebClientConstants.mainObjectKey] as? JSONDictionary,
                            let mainModel = MainModel(jsonDictionary: mainDictionary)
                        else {
                            os_log(OSLogConstants.WebService.errorFailedDataModeling, log: .webService, type: .error)
                            return
                        }
                        
                        let weatherDataModel = WeatherDataModel(description: weatherModel.description,
                                                                icon: weatherModel.icon,
                                                                temp: mainModel.temp,
                                                                tempMin: mainModel.tempMin,
                                                                tempMax: mainModel.tempMax)
                        
                        //TODO: Display results in UI on the main thread.
                        completion(weatherDataModel, nil)
        })
    }
}
