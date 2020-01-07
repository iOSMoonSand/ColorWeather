//
//  ColorConstants.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/27/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

typealias ColorGradient = (start: Color, end: Color)

struct ColorConstants {
    
    // MARK: - Sky
    struct Sky {
        
        // MARK: Day
        struct Day {
            
            static let clear = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.dayClearSky.start,
                                            ColorGradients.dayClearSky.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let fewClouds = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.dayFewClouds.start,
                                            ColorGradients.dayFewClouds.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let scatteredClouds = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.dayScatteredClouds.start,
                                            ColorGradients.dayScatteredClouds.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let brokenClouds = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.dayBrokenClouds.start,
                                            ColorGradients.dayBrokenClouds.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let showerRain = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.dayShowerRain.start,
                                            ColorGradients.dayShowerRain.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let rain = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.dayRain.start,
                                            ColorGradients.dayRain.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let thunderstorm = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.dayThunderstorm.start,
                                            ColorGradients.dayThunderstorm.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let snow = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.daySnow.start,
                                            ColorGradients.daySnow.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let mist = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.dayMist.start,
                                            ColorGradients.dayMist.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        }
        
        // MARK: Night
        struct Night {
            
            static let clear = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.nightClearSky.start,
                                            ColorGradients.nightClearSky.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let fewClouds = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.nightFewClouds.start,
                                            ColorGradients.nightFewClouds.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let scatteredClouds = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.nightScatteredClouds.start,
                                            ColorGradients.nightScatteredClouds.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let brokenClouds = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.nightBrokenClouds.start,
                                            ColorGradients.nightBrokenClouds.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let showerRain = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.nightShowerRain.start,
                                            ColorGradients.nightShowerRain.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let rain = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.nightRain.start,
                                            ColorGradients.nightRain.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let thunderstorm = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.nightThunderstorm.start,
                                            ColorGradients.nightThunderstorm.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let snow = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.nightSnow.start,
                                            ColorGradients.nightSnow.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            
            static let mist = LinearGradient(
                gradient: Gradient(colors: [ColorGradients.nightMist.start,
                                            ColorGradients.nightMist.end]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        }
    }
    
    // MARK: - Text
    struct Text {
        static let darkGray = Color(red: 95/255,
                                    green: 95/255,
                                    blue: 95/255)
    }
    
    
    // MARK: - Private
    // MARK: -
    
    // MARK: ColorGradients
    private struct ColorGradients {
        
        static let dayClearSky = ColorGradient(start: Color(red: 0/255,
                                                            green: 113/255,
                                                            blue: 255/255),
                                               end: Color(red: 164/255,
                                                          green: 203/255,
                                                          blue: 253/255))
        
        static let nightClearSky = ColorGradient(start: Color(red: 3/255,
                                                              green: 1/255,
                                                              blue: 19/255),
                                                 end: Color(red: 44/255,
                                                            green: 19/255,
                                                            blue: 106/255))
        
        static let dayFewClouds = ColorGradient(start: Color(red: 34/255,
                                                             green: 132/255,
                                                             blue: 255/255),
                                                end: Color(red: 228/255,
                                                           green: 233/255,
                                                           blue: 238/255))
        
        static let nightFewClouds = ColorGradient(start: Color(red: 3/255,
                                                               green: 1/255,
                                                               blue: 19/255),
                                                  end: Color(red: 56/255,
                                                             green: 56/255,
                                                             blue: 85/255))
        
        static let dayScatteredClouds = ColorGradient(start: Color(red: 70/255,
                                                                   green: 134/255,
                                                                   blue: 215/255),
                                                      end: Color(red: 228/255,
                                                                 green: 233/255,
                                                                 blue: 238/255))
        
        static let nightScatteredClouds = ColorGradient(start: Color(red: 3/255,
                                                                     green: 1/255,
                                                                     blue: 19/255),
                                                        end: Color(red: 56/255,
                                                                   green: 56/255,
                                                                   blue: 85/255))
        
        static let dayBrokenClouds = ColorGradient(start: Color(red: 121/255,
                                                                green: 180/255,
                                                                blue: 255/255),
                                                   end: Color(red: 228/255,
                                                              green: 233/255,
                                                              blue: 238/255))
        
        static let nightBrokenClouds = ColorGradient(start: Color(red: 3/255,
                                                                  green: 1/255,
                                                                  blue: 19/255),
                                                     end: Color(red: 56/255,
                                                                green: 56/255,
                                                                blue: 85/255))
        
        static let dayShowerRain = ColorGradient(start: Color(red: 65/255,
                                                              green: 78/255,
                                                              blue: 96/255),
                                                 end: Color(red: 192/255,
                                                            green: 198/255,
                                                            blue: 204/255))
        
        static let nightShowerRain = ColorGradient(start: Color(red: 3/255,
                                                                green: 1/255,
                                                                blue: 19/255),
                                                   end: Color(red: 56/255,
                                                              green: 56/255,
                                                              blue: 85/255))
        
        static let dayRain = ColorGradient(start: Color(red: 96/255,
                                                        green: 130/255,
                                                        blue: 176/255),
                                           end: Color(red: 192/255,
                                                      green: 198/255,
                                                      blue: 204/255))
        
        static let nightRain = ColorGradient(start: Color(red: 3/255,
                                                          green: 1/255,
                                                          blue: 19/255),
                                             end: Color(red: 56/255,
                                                        green: 56/255,
                                                        blue: 85/255))
        
        static let dayThunderstorm = ColorGradient(start: Color(red: 65/255,
                                                                green: 78/255,
                                                                blue: 96/255),
                                                   end: Color(red: 192/255,
                                                              green: 198/255,
                                                              blue: 204/255))
        
        static let nightThunderstorm = ColorGradient(start: Color(red: 3/255,
                                                                  green: 1/255,
                                                                  blue: 19/255),
                                                     end: Color(red: 56/255,
                                                                green: 56/255,
                                                                blue: 85/255))
        
        static let daySnow = ColorGradient(start: Color(red: 166/255,
                                                        green: 206/255,
                                                        blue: 255/255),
                                           end: Color(red: 238/255,
                                                      green: 241/255,
                                                      blue: 244/255))
        
        static let nightSnow = ColorGradient(start: Color(red: 3/255,
                                                          green: 1/255,
                                                          blue: 19/255),
                                             end: Color(red: 181/255,
                                                        green: 171/255,
                                                        blue: 206/255))
        
        static let dayMist = ColorGradient(start: Color(red: 87/255,
                                                        green: 161/255,
                                                        blue: 255/255),
                                           end: Color(red: 189/255,
                                                      green: 221/255,
                                                      blue: 253/255))
        
        static let nightMist = ColorGradient(start: Color(red: 3/255,
                                                          green: 1/255,
                                                          blue: 19/255),
                                             end: Color(red: 119/255,
                                                        green: 108/255,
                                                        blue: 147/255))
    }
    
    
    static let defaultBackground = UIColor(red: 248/255,
                                           green: 252/255,
                                           blue: 252/255,
                                           alpha: 1/1)
    
    static let settingsGradient: ColorGradient = (
        start: Color(red: 0/255,
                     green: 113/255,
                     blue: 255/255),
        end: Color(red: 164/255,
                   green: 203/255,
                   blue: 253/255)
    )
}
