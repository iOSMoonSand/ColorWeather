//
//  UserDefault.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 12/31/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import Foundation
import Combine

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
