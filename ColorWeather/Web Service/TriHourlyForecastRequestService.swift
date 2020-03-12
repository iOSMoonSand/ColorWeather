//
//  TriHourlyForecastRequestService.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 12/30/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import Foundation

import Foundation
import os

final class TriHourlyForecastRequestService {
    
    private let client = WebClient(baseURL: URL(string: WebClientConstants.baseURLString)!)
    
    func requestForecastData(from coordinates: LocationCoordinates,
                             completion: @escaping (([TriHourlyForecastDataModel?]?, RequestError?) -> Void)) {
        
        let parameters: JSONDictionary = [
            WebClientConstants.coordinatesKey.latitude: coordinates.latitude,
            WebClientConstants.coordinatesKey.longitude: coordinates.longitude,
            WebClientConstants.appIdKey: AppSecrets.openWeatherAPIKey
        ]
        
        client.request(with: WebClientConstants.triHourlyForecastPath,
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
                            let cityDictionary = dataDictionary["city"] as? JSONDictionary,
                            let timezone = cityDictionary[WebClientConstants.timezoneObjectKey] as? Double,
                            let listArray = dataDictionary[WebClientConstants.listObjectKey] as? [JSONDictionary]
                            else {
                                os_log(OSLogConstants.WebService.errorFailedDataModeling, log: .webService, type: .error)
                                return
                        }
                        
                        let forecastDataModels: [TriHourlyForecastDataModel?] = listArray.prefix(3).map {
                            
                            guard
                                let weatherArray = $0[WebClientConstants.weatherObjectKey] as? [JSONDictionary],
                                let weatherDictionary = weatherArray.first,
                                let weatherModel = WeatherModel(jsonDictionary: weatherDictionary),
                                let mainDictionary = $0[WebClientConstants.mainObjectKey] as? JSONDictionary,
                                let mainModel = MainModel(jsonDictionary: mainDictionary),
                                let timeOfDataForecasted = $0[WebClientConstants.dtObjectKey] as? Double
                                else {
                                    os_log(OSLogConstants.WebService.errorFailedDataModeling, log: .webService, type: .error)
                                    return nil
                            }
                            
                            let date = Date(timeIntervalSince1970: timeOfDataForecasted + timezone)
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "E ha"
                            let strDate = dateFormatter.string(from: date)
                            
                            return TriHourlyForecastDataModel(forecastTime: strDate,
                                                              icon: weatherModel.icon,
                                                              tempMax: mainModel.tempMax,
                                                              tempMin: mainModel.tempMin)
                        }
                        
                        completion(forecastDataModels, nil)
        })
    }
}
