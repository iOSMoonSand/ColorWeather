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
    
    static let clGeocoder = OSLog(subsystem: subsystem, category: "CLGeocoder")
    static let coreData = OSLog(subsystem: subsystem, category: "Core Data")
    static let general = OSLog(subsystem: subsystem, category: "General")
    static let webService = OSLog(subsystem: subsystem, category: "Web Service")
}
