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
typealias LocationCoordinates = (latitude: Double, longitude: Double)

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
    static let coordinatesKey = (latitude: "lat", longitude: "lon")
    
    // URL Components
    static let baseURLString = "https://api.openweathermap.org/data/2.5"
    static let weatherPath = "/weather"
    static let triHourlyForecastPath = "/forecast"
    
    // Response Object Keys
    static let weatherObjectKey = "weather"
    static let mainObjectKey = "main"
    static let dtObjectKey = "dt"
    static let listObjectKey = "list"
    static let sysObjectKey = "sys"
    static let timezoneObjectKey = "timezone"
}

final class WebClient {
    
    private let session: URLSession
    private let baseURL: URL
    
    init(session: URLSession = URLSession(configuration: .default),
         baseURL: URL) {
        self.session = session
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
        
        
        var dataTask: URLSessionDataTask?
        
        dataTask?.cancel()
        
        guard let url = URL(baseURL: baseURL, path: path, parameters: parameters) else {
            os_log(OSLogConstants.WebService.errorInvalidURL, log: .webService, type: .error)
            completion(nil, RequestError.invalidURL)
            return
        }
        
        // TODO: needs more comments and maybe refacto
        dataTask = session.dataTask(with: url) { data, response, error in
            
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
            
            do {
                let dataDictionary: JSONDictionary? = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
                completion(dataDictionary, nil)
                
            } catch {
                // The do-catch statement includes a local variable `error` to handle all thrown error types.
                os_log(OSLogConstants.Shared.errorFailedSerialization, log: .webService, type: .error, error.localizedDescription)
                completion(nil, RequestError.failedJSONSerialization)
            }
        }
        
        dataTask?.resume()
    }
}
