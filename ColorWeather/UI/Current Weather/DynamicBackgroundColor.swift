//
//  DynamicBackgroundColor.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 01/03/20.
//  Copyright © 2020 iOS MoonSand. All rights reserved.
//

import SwiftUI

struct DynamicBackgroundColor: View {
    
    let colorCodes: [String: LinearGradient] = [
        ColorMap.dayClearSky.rawValue: ColorConstants.Sky.Day.clear,
        ColorMap.nightClearSky.rawValue: ColorConstants.Sky.Night.clear,
        ColorMap.dayFewClouds.rawValue: ColorConstants.Sky.Day.fewClouds,
        ColorMap.nightFewClouds.rawValue: ColorConstants.Sky.Night.fewClouds,
        ColorMap.dayScatteredClouds.rawValue: ColorConstants.Sky.Day.scatteredClouds,
        ColorMap.nightScatteredClouds.rawValue: ColorConstants.Sky.Night.scatteredClouds,
        ColorMap.dayBrokenClouds.rawValue: ColorConstants.Sky.Day.brokenClouds,
        ColorMap.nightBrokenClouds.rawValue: ColorConstants.Sky.Night.brokenClouds,
        ColorMap.dayShowerRain.rawValue: ColorConstants.Sky.Day.showerRain,
        ColorMap.nightShowerRain.rawValue: ColorConstants.Sky.Night.showerRain,
        ColorMap.dayRain.rawValue: ColorConstants.Sky.Day.rain,
        ColorMap.nightRain.rawValue: ColorConstants.Sky.Night.rain,
        ColorMap.dayThunderstorm.rawValue: ColorConstants.Sky.Day.thunderstorm,
        ColorMap.nightThunderstorm.rawValue: ColorConstants.Sky.Night.thunderstorm,
        ColorMap.daySnow.rawValue: ColorConstants.Sky.Day.snow,
        ColorMap.nightSnow.rawValue: ColorConstants.Sky.Night.snow,
        ColorMap.dayMist.rawValue: ColorConstants.Sky.Day.mist,
        ColorMap.nightMist.rawValue: ColorConstants.Sky.Night.mist,
    ]
    
    var id: String?
    
    var body: some View {
        
        let defaultGradient = LinearGradient(
            gradient: Gradient(colors: [ColorConstants.settingsGradient.start,
                                        ColorConstants.settingsGradient.end]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
        
        guard let id = id else {
            return defaultGradient
        }
        
        return colorCodes[id] ?? defaultGradient
    }
}

struct DynamicBackgroundColor_Previews: PreviewProvider {
    static var previews: some View {
        DynamicBackgroundColor(id: "01d")
    }
}
