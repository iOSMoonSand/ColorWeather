//
//  WebServiceTests.swift
//  ColorWeatherTests
//
//  Created by Alexis Schreier on 12/03/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import XCTest

@testable import ColorWeather

class WebServiceTests: XCTestCase {
    
    private var client: WebClient!
    private var requestURL: URL!
    let path = "/posts/22"

    override func setUp() {
        
        let baseURL = URL(string: "https://jsonplaceholder.typicode.com")
        var urlComponents = URLComponents(url: baseURL!,
                                                resolvingAgainstBaseURL: true)!
        urlComponents.path += path
        requestURL = urlComponents.url!
        
        // The system will create an instance of registered protocol classes and call the “canInit” method
        // on them to see if the class can handle the current request. If so, it will give responsibility
        // to that registered class to complete the network operation.
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        client = WebClient(session: session,
                           baseURL: baseURL!)
    }

    override func tearDown() {
        client = nil
        MockURLProtocol.requestHandler = nil
    }
    
    /// We'll return valid JSON response data to test if the client successfully creates an object with that data.
    func testResponseSuccess() {
        
        // Create the mock JSON data.
        let userId = 3
        let id = 22
        let title = "Underpants Gnomes Profit Plan"
        let body = "Phase 1. Collect underpants, Phase 2. ???, Phase 3. Profit"
        
        // Create a mock JSON object with the same values as the above mock data
        let jsonString = """
        {"userId": 3,"id": 22,"title": "Underpants Gnomes Profit Plan","body": "Phase 1. Collect underpants, Phase 2. ???, Phase 3. Profit"}
        """
        
        let data = jsonString.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            
            guard
                let url = request.url,
                url == self.requestURL
            else {
                throw RequestError.invalidURL
            }
            
            // Test that the request URL is the correct URL we passed to the client.
            XCTAssertEqual(url, self.requestURL)
            
            let response = HTTPURLResponse(url: self.requestURL,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            
            return (response, data)
        }
        
        let expectation = self.expectation(description: "Client Request Sucess")
        
        client.request(with: path,
                       parameters: JSONDictionary()) { data, error in
                        
                        XCTAssertNil(error)
                        
                        guard let dataDictionary = data else {
                            XCTFail("Data is not supposed to be nil.")
                            expectation.fulfill()
                            return
                        }
                        
                        XCTAssertEqual((dataDictionary["userId"] as! Int), userId)
                        XCTAssertEqual((dataDictionary["id"] as! Int), id)
                        XCTAssertEqual((dataDictionary["title"] as! String), title)
                        XCTAssertEqual((dataDictionary["body"] as! String), body)
                        
                        expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testResponseError() {
        
        // Create empty mock data.
        let data = Data()
        
        MockURLProtocol.requestHandler = { request in
            
            let response = HTTPURLResponse(url: self.requestURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        let expectation = self.expectation(description: "Client Request Failure")
        
        client.request(with: path,
                       parameters: JSONDictionary()) { data, error in
                        
                        XCTAssertNil(data)
                        XCTAssertEqual(error, RequestError.failedJSONSerialization, "Failed JSON serialization error was expected.")
                        
                        expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
