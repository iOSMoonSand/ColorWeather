//
//  RequestError.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 10/16/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case invalidURL
    case failedJSONSerialization
    case notConnectedToInternet
    case unknown
}

extension RequestError: LocalizedError {
    var errorDescription: String? {
        
        switch self {
        case .invalidURL,
             .failedJSONSerialization,
             .unknown:
            return "Oops, we're having some trouble getting your weather data. Please try again later."
            
        case .notConnectedToInternet:
            return "Darn, it looks like you're not connected to the Internet."
        }
    }
}
