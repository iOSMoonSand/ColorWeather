//
//  Client.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 09/19/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct ClientConstants {
    // Keys
    static let appIdKey = "appid"
    static let queryKey = "q"
    
    // URL Components
    static let baseURL = "https://api.openweathermap.org/data/2.5"
    static let weatherPath = "/weather"
    
    // Response Object Keys
    static let weatherObjectKey = "weather"
    static let mainObjectKey = "main"
}

final class Client {
    
    private let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    // TODO: replace Error with custom error class
    func request(with path: String, method: RequestMethod? = nil, parameters: JSONDictionary, completion: @escaping (JSONDictionary?, Error?) -> Void ) {
        
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        
        dataTask?.cancel()
        
        // Add the common parameters to the passed-in dictionary.
        var params = parameters
        params[ClientConstants.appIdKey] = AppSecrets.openWeatherAPIKey
        
        guard let url = URL(baseURL: baseURL, path: path, parameters: params) else {
            // TODO: review errors and logging and nil results
            return
        }
        
        // TODO: needs more comments and maybe refacto
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            
            defer {
                dataTask = nil
            }
            
            if let error = error {
                completion(nil, error)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse {
                
                // TODO: review errors and logging and nil results
                print("*** Response: \(response)")
                
                var dataDictionary: [String: Any]?
                
                do {
                    dataDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
                    completion(dataDictionary, nil)
                    
                // TODO: review errors and logging and nil results
                } catch let parseError as NSError {
                    completion(nil, parseError)
                }
            }
        }
        
        dataTask?.resume()
    }
}
