//
//  OSLog+Extension.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 10/18/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import Foundation
import os

// MARK: Log Levels Legend

// Default: 🔵
//    Info: 💡
//   Debug: 🛠
//   Error: ❌
//   Fault: ⚠️

extension OSLog {
    
    private static let subsystem = Bundle.main.bundleIdentifier!
    
    // MARK: Custom Categories
    static let webService = OSLog(subsystem: subsystem, category: "Web Service")
}
