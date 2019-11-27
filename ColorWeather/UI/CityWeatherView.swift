//
//  CityWeatherView.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/19/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

struct CityWeatherView: View {
    
    private var cityName: String
    
    init(_ cityName: String) {
        self.cityName = cityName
    }
    
    var body: some View {
        Text(cityName)
    }
}

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherView(cityName: "Le Havre")
    }
}
