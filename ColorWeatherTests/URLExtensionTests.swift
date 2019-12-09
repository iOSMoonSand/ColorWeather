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

    override func setUp() {
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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
