//
//  OSLogConstants.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 10/21/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

struct OSLogConstants {
    
    struct WebService {
        
        static let errorInvalidURL: StaticString = "❌ Invalid URL."
        static let errorNilData: StaticString = "❌ Data object is nil."
        static let errorNoInternet: StaticString = "❌ Not connected to Internet."
        static let errorFailedDataModeling: StaticString = "❌ There was an error creating a model object with the data received from your request."
        static let errorFailedSerialization: StaticString = "❌ There was an error when trying to serialize the retrieved JSON data: %{public}@"
        static let errorFailedRequest: StaticString = "❌ HTTP request operation failed with status code: %d."
        static let errorUnknown: StaticString = "❌ An unkown error occured: %{public}@"
    }
}
