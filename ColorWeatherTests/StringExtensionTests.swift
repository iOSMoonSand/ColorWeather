//
//  StringExtensionTests.swift
//  ColorWeatherTests
//
//  Created by Alexis Schreier on 12/09/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import XCTest

@testable import ColorWeather

class StringExtensionTests: XCTestCase {

    func testFirstCapitalizedString() {
        
        let lowercase = "how you doin?"
        let firstCapitalized = lowercase.firstCapitalized
        
        XCTAssertEqual(firstCapitalized, "How you doin?")
    }

}
