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
                            let mainModel = MainModel(jsonDictionary: mainDictionary),
                            let sysDictionary = dataDictionary[WebClientConstants.sysObjectKey] as? JSONDictionary,
                            let sysModel = SysModel(jsonDictionary: sysDictionary),
                            let sunriseTimestamp = sysModel.sunrise,
                            let sunsetTimestamp = sysModel.sunset,
                            let timeOfData = dataDictionary[WebClientConstants.dtObjectKey] as? Double,
                            let timezone = dataDictionary[WebClientConstants.timezoneObjectKey] as? Double
                        else {
                            os_log(OSLogConstants.WebService.errorFailedDataModeling, log: .webService, type: .error)
                            return
                        }
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                        dateFormatter.locale = NSLocale.current
                        dateFormatter.dateFormat = "h:mm a"
                        
                        let sunriseDate = Date(timeIntervalSince1970: sunriseTimestamp + timezone)
                        let sunriseStringDate = dateFormatter.string(from: sunriseDate)
                        
                        let sunsetDate = Date(timeIntervalSince1970: sunsetTimestamp + timezone)
                        let sunsetStringDate = dateFormatter.string(from: sunsetDate)
                        
                        let weatherDataModel = WeatherDataModel(description: weatherModel.description,
                                                                dt: timeOfData,
                                                                icon: weatherModel.icon,
                                                                sunrise: sunriseStringDate,
                                                                sunset: sunsetStringDate,
                                                                temp: mainModel.temp,
                                                                tempMin: mainModel.tempMin,
                                                                tempMax: mainModel.tempMax)
                        
                        completion(weatherDataModel, nil)
        })
    }
}
