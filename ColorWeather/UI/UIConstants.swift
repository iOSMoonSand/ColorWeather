//
//  UIConstants.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/26/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import UIKit

struct UIConstants {
    
    // MARK: - Shared
    struct Shared {
        
        // MARK: Assets
        struct Assets {
            static let menu = "menu"
        }
    }
    
    // MARK: - CurrentWeather
    struct CurrentWeather {
        
        // Time interval of 10 min. Open Weather Map API updates it's data no more than once every 10 min.
        static let refreshTimeInterval: Double = 600
    }
}
