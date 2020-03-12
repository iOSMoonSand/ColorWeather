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

    let objectWillChange = PassthroughSubject<Void, Never>()

    @UserDefault("UnitsInFahrenheit", defaultValue: true)
    var unitsInFahrenheit: Bool {
        willSet {
            objectWillChange.send()
        }
    }
    
    // TODO: Replace default values with empty state.
    @UserDefault("Cities", defaultValue: [])
    var cities: [String] {
        willSet {
            objectWillChange.send()
        }
    }
}
