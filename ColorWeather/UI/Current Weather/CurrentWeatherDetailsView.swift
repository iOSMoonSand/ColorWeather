//
//  CurrentWeatherDetailsView.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 03/12/20.
//  Copyright © 2020 iOS MoonSand. All rights reserved.
//

import SwiftUI

/// The details view holds the data that can be seen between the current temperature and the forcast.
/// Currently it includes sunset and sunrise times and low/high temps.
struct CurrentWeatherDetailsView: View {
    
    var highLowSymbol: String
    var temp: String
    var isSunset: Bool
    var sunTime: String
    
    var body: some View {
        
        let sunBehavior = isSunset ? UIConstants.Shared.sunset : UIConstants.Shared.sunrise
        let alignment = isSunset ? HorizontalAlignment.leading : HorizontalAlignment.trailing
        
        return VStack(alignment: alignment) {
            
            // Low/High temp
            HStack(alignment: .firstTextBaseline) {
                
                Text(highLowSymbol)
                    .font(.system(size: 20))
                    .fontWeight(.thin)
                    .foregroundColor(Color.white)
                    .shadow(radius: 1)
                
                Text(temp)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
                    .shadow(radius: 1)
            }.padding([.bottom], 15)
            
            // Sunset/sunrise
            Text(sunBehavior)
                .font(.system(size: 16))
                .fontWeight(.thin)
                .foregroundColor(Color.white)
                .shadow(radius: 1)
            
            Text(sunTime)
                .font(.system(size: 24))
                .foregroundColor(Color.white)
                .shadow(radius: 1)
        }
    }
}

struct CurrentWeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherDetailsView(highLowSymbol: UIConstants.Shared.lowTempSymbol,
                                  temp: "30",
                                  isSunset: true,
                                  sunTime: "6:53PM")
    }
}
