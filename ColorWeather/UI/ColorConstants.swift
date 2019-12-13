//
//  ColorConstants.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/27/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

struct ColorConstants {
    
    static let defaultBackground = UIColor(red: 248/255,
                                           green: 252/255,
                                           blue: 252/255,
                                           alpha: 1/1)
    
    // MARK: - Sky
    struct Sky {
        
        // MARK: Day
        struct Day {
            static let clearGradientStart = Color(red: 32/255,
                                                  green: 155/255,
                                                  blue: 255/255)
            static let clearGradientEnd = Color(red: 179/255,
                                                green: 221/255,
                                                blue: 255/255)
        }
    }
}
