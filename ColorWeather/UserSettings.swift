//
//  UserSettings.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 12/30/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI
import Combine

final class UserSettings: ObservableObject {
    
    init() {
        self.unitsInFahrenheit = UserDefaults.standard.object(forKey: "UnitsInFahrenheit") as? Bool ?? true
        self.cities = UserDefaults.standard.object(forKey: "Cities") as? [String] ?? [String]()
    }

    @Published
    var unitsInFahrenheit: Bool = true {
        didSet {
            UserDefaults.standard.set(unitsInFahrenheit, forKey: "UnitsInFahrenheit")
        }
    }
    
    @Published
    var cities: [String] = []
}
