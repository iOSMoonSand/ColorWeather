//
//  Date+Extension.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 12/10/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import Foundation

extension Date {
    
    /// Returns a boolean value indicating if the subject time was exceeded of not compared to the current time.
    /// - Parameters:
    ///   - baseTime: Time we want to compare with the current time.
    ///   - buffer: Time we want to add to our base time.
    ///   - currentTime: The current time as a Foundation TimeInterval.
    static func exceeds(baseTime: Double, buffer: Double, currentTime: TimeInterval) -> Bool {
        let maxTimeBeforeExceeded = baseTime + buffer
        return maxTimeBeforeExceeded < currentTime
    }
}
