//
//  ForecastRow.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 03/12/20.
//  Copyright © 2020 iOS MoonSand. All rights reserved.
//

import SwiftUI

struct ForecastRow: View {
    
    var time: String
    var icon: String
    var lowTemp: String
    var highTemp: String
    
    var body: some View {
        ZStack(alignment: .center) {
            HStack(spacing: 60) {
                Text(time)
                    .foregroundColor(Color.white)
                    .shadow(radius: 1)
                    .frame(width: 120, height: 40, alignment: .trailing)
                
                HStack {
                    HStack(spacing: 3) {
                        Text(UIConstants.Shared.lowTempSymbol)
                            .foregroundColor(Color.white)
                            .shadow(radius: 1)
                        Text(lowTemp)
                            .foregroundColor(Color.white)
                            .shadow(radius: 1)
                    }
                    HStack(spacing: 3) {
                        Text(UIConstants.Shared.highTempSymbol)
                            .foregroundColor(Color.white)
                            .shadow(radius: 1)
                        Text(highTemp)
                            .foregroundColor(Color.white)
                            .shadow(radius: 1)
                    }
                }
                .frame(width: 120, height: 40, alignment: .leading)
            }
            
            if !icon.isEmpty {
                Image(icon).asThumbnail()
            } else {
                Text(UIConstants.Shared.noDataDefault)
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct ForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        ForecastRow(time: "Tue 4PM", icon: "01d", lowTemp: "81", highTemp: "88")
    }
}
