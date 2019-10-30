//
//  WeatherDataRequestService.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 10/15/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import os

final class WeatherDataRequestService {
    
    private let client = WebClient(baseURL: WebClientConstants.baseURL)
    
    func requestWeatherData(from searchTerms: String,
                        completion: @escaping ((WeatherDataModel?, RequestError?) -> Void)) {
        
        // TODO: will need mechanism to clean search terms string before it can be used as a URL component
        let parameters: JSONDictionary = [WebClientConstants.queryKey: searchTerms]
        
        client.request(with: WebClientConstants.weatherPath,
                       parameters: parameters,
                       completion: { dataDictionary, error in
                        
                        switch error {
                        case .some(let error) where error == RequestError.notConnectedToInternet:
                            //TODO: Display notConnectedToInternet error message in UI using `error.errorDescription` on the main thread.
                            completion(nil, error)
                            
                        case .some(let error):
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
