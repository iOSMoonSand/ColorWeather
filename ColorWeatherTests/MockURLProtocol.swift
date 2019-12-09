//
//  MockURLProtocol.swift
//  ColorWeatherTests
//
//  Created by Alexis Schreier on 12/03/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import Foundation

/// When you make a request, Apple's URLSession looks internally at a series of registered protocol
/// handlers to figure out which one to use to make the request. All these handlers conform to
/// URLProtocol and you can design your own custom handler and then register it to a session. We can
/// then manipulate our own returned data from the initiated request in order to test that our session
/// is working properly.
class MockURLProtocol: URLProtocol {
    
    
    /// Closure to test the request and return a mock response.
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
    
    // Since we want to handle all requests, we always return true.
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    // We don't want to do any special processing here so we return the unaltered request.
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        guard let requestHandler = MockURLProtocol.requestHandler else {
            fatalError("The request handler is nil.")
        }
        
        do {
            // We have received a request so we call the handler and try to capture the response/data tuple.
            let (response, data) = try requestHandler(request)
            // Tells the client that we've created a response object for the request.
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let data = data {
                // Tells the client that we have loaded some data.
                client?.urlProtocol(self, didLoad: data)
            }
            
            client?.urlProtocolDidFinishLoading(self)
            
        } catch {
            // Tells the client there was an error loading data.
            client?.urlProtocol(self, didFailWithError: error)
        }
        
    }
    
    override func stopLoading() {
        // Empty.
    }
}
