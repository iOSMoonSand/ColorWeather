//
//  DateExtensionTests.swift
//  ColorWeatherTests
//
//  Created by Alexis Schreier on 12/10/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import XCTest

@testable import ColorWeather

class DateExtensionTests: XCTestCase {

    func testExceedsTimeTrue() {
        
        let currentTime: TimeInterval = Date().timeIntervalSince1970
        let baseTime: Double = 1575990105                                       // Tuesday, December 10, 2019 3:01:45 PM GMT
        let buffer: Double = 10                                                 // 10 sec buffer
        
        XCTAssertTrue(Date.exceeds(baseTime: baseTime,
                                   buffer: buffer,
                                   currentTime: currentTime))
        
    }
    
    func testExceedsTimeFalse() {
        
        let currentTime: TimeInterval = Date().timeIntervalSince1970
        let baseTime: Double = 1575990105 + 1000000000                          // Friday, August 18, 2051 4:48:25 PM GMT
        let buffer: Double = 10                                                 // 10 sec buffer
        
        XCTAssertFalse(Date.exceeds(baseTime: baseTime,
                                   buffer: buffer,
                                   currentTime: currentTime))
        
    }

}
