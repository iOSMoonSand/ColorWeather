//
//  CityData.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 12/12/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

class CityData: ObservableObject {
    
    @Published var cities: [String]
    
    init(cities: [String]) {
        self.cities = cities
    }
}
