//
//  UserDefault.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 12/31/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import Foundation
import Combine

/// This is a property wrapper as seen by the declared @propertyWrapper attribute.
/// This means we can access it by calling @UserDefault thanks to Swift syntactic sugar.
/// Its wrappedValue property defines what you access when getting/setting the property being wrapped.
/// @UserDefaults allows the wrapped property to access the system's standard shared UserDefaults
/// and assign a default value at initialization.
@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    // This property is given to us by Combine.
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
