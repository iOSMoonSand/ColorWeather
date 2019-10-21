//
//  URL+Extension.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 09/20/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import Foundation

extension URL {
    
    init?(baseURL: String, path: String, parameters: JSONDictionary) {
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        
        urlComponents.path += path
        urlComponents.queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: String(describing: $0.value))
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        self = url
    }
}
