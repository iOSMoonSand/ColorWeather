//
//  SettingsAddedCityRow.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 12/28/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

struct SettingsAddedCityRow: View {
    
    var addedCity: SettingsAddedCity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(addedCity.cityName)
                .font(.system(size: 20))
                .padding([.leading, .top, .bottom], 10)
        }
        
    }
}

struct SettingsAddedCityRow_Previews: PreviewProvider {
    
    static let addedCity = SettingsAddedCity(cityName: "Toronto")
    static var previews: some View {
        SettingsAddedCityRow(addedCity: addedCity)
    }
}
