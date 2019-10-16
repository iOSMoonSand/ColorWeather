//
//  GetWeatherDataService.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 10/15/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

final class GetWeatherDataService {
    
    private let client = Client(baseURL: ClientConstants.baseURL)
    
    func getWeatherData(from searchTerms: String,
                        completion: @escaping ((WeatherDataModel?, Error?) -> Void)) {
        
        // TODO: will need mechanism to clean search terms string before it can be used as a URL component
        let parameters: JSONDictionary = [ClientConstants.queryKey: searchTerms]
        client.request(with: ClientConstants.weatherPath,
                       parameters: parameters,
                       completion: { dataDictionary, error in
                        
                        guard error == nil else {
                            completion(nil, error)
                            // TODO: review errors and logging and nil results
                            return
                        }
                        
                        guard
                            let dataDictionary = dataDictionary,
                            let weatherArray = dataDictionary[ClientConstants.weatherObjectKey] as? [JSONDictionary],
                            let weatherDictionary = weatherArray.first,
                            let weatherModel = WeatherModel(jsonDictionary: weatherDictionary),
                            let mainDictionary = dataDictionary[ClientConstants.mainObjectKey] as? JSONDictionary,
                            let mainModel = MainModel(jsonDictionary: mainDictionary)
                        else {
                            // TODO: review errors and logging and nil results
                            return
                        }
                        
                        let weatherDataModel = WeatherDataModel(description: weatherModel.description,
                                                                icon: weatherModel.icon,
                                                                temp: mainModel.temp,
                                                                tempMin: mainModel.tempMin,
                                                                tempMax: mainModel.tempMax)
                        
                        completion(weatherDataModel, nil)
        })
    }
}
