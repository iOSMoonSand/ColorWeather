//
//  URLExtensionTests.swift
//  ColorWeatherTests
//
//  Created by Alexis Schreier on 12/09/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import XCTest

@testable import ColorWeather

class URLExtensionTests: XCTestCase {

    func testURLAssembly() {
        
        let baseURL = URL(string: "twitter.com")
        let path = "/search"
        let params = ["q": "swift"]
        
        let searchEndpointURL = URL(baseURL: baseURL!, path: path, parameters: [:])
        XCTAssertEqual(searchEndpointURL, URL(string: "twitter.com/search"))
        
        let searchQueryURL = URL(baseURL: baseURL!, path: path, parameters: params)
        XCTAssertEqual(searchQueryURL, URL(string: "twitter.com/search?q=swift"))
    }

}
