//
//  WebClient.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 09/19/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import Foundation
import os

typealias JSONDictionary = [String: Any]

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct WebClientConstants {
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

final class WebClient {
    
    private let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    // TODO: Implement code to handle request method other than the default GET.
    
    /// This method performs an http request to the OpenWeather API.
    /// - Parameter path: The API endpoint we want to query i.e "/weather"
    /// - Parameter method: The request method we want to query the API with i.e GET, POST, etc.
    /// - Parameter parameters: The query parameters to add in the URL.
    /// - Parameter completion: An asynchronous closure that handles the reponse whether it's data or an error.
    func request(with path: String,
                 method: RequestMethod? = nil,
                 parameters: JSONDictionary,
                 completion: @escaping (JSONDictionary?, RequestError?) -> Void) {
        
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        
        dataTask?.cancel()
        
        // Add the common parameters to the passed-in dictionary.
        var params = parameters
        params[WebClientConstants.appIdKey] = AppSecrets.openWeatherAPIKey
        
        guard let url = URL(baseURL: baseURL, path: path, parameters: params) else {
            os_log(OSLogConstants.WebService.errorInvalidURL, log: .webService, type: .error)
            completion(nil, RequestError.invalidURL)
            return
        }
        
        // TODO: needs more comments and maybe refacto
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            
            // Once we've completed the data task we kill it to make sure
            // a new one gets initialized the next time we want to perform one.
            defer {
                dataTask = nil
            }
            
            switch error {
            case .some(let error as NSError) where error.code == NSURLErrorNotConnectedToInternet:
                os_log(OSLogConstants.WebService.errorNoInternet, log: .webService, type: .error)
                completion(nil, RequestError.notConnectedToInternet)
                return
                
            case .some(let error):
                os_log(OSLogConstants.WebService.errorUnknown, log: .webService, type: .error, error.localizedDescription)
                completion(nil, RequestError.unknown)
                return
                
            case .none:
                break
            }
            
            guard let data = data else {
                os_log(OSLogConstants.WebService.errorNilData, log: .webService, type: .error)
                return
            }
            
            // Safe to force cast according to the docs:
            // Whenever you make HTTP URL load requests, any response objects you get back from the
            // URLSession, NSURLConnection, or NSURLDownload class are instances of the HTTPURLResponse class.
            let httpResponse = response as! HTTPURLResponse
            
            guard (200..<300) ~= httpResponse.statusCode else {
                os_log(OSLogConstants.WebService.errorFailedRequest, log: .webService, type: .error, httpResponse.statusCode)
                return
            }
            
            var dataDictionary: JSONDictionary?
            
            do {
                dataDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
                completion(dataDictionary, nil)
                
            } catch {
                // The do-catch statement includes a local variable `error` to handle all thrown error types.
                os_log(OSLogConstants.WebService.errorFailedSerialization, log: .webService, type: .error, error.localizedDescription)
                completion(nil, error as? RequestError)
            }
        }
        
        dataTask?.resume()
    }
}
