//
//  CitySearchCompleter.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/04/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import Combine
import MapKit
import SwiftUI

final class CitySearchCompleter: NSObject, ObservableObject {
    
    let objectWillChange = ObservableObjectPublisher()
    
    var results: [String] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    private var completer: MKLocalSearchCompleter
    
    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        completer.resultTypes = .address
        completer.delegate = self
    }
    
    func search(with queryFragment: String) {
        completer.queryFragment = queryFragment
    }
}

extension CitySearchCompleter: MKLocalSearchCompleterDelegate {

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {

        DispatchQueue.main.async { [weak self] in
            self?.results = completer.results.map {
                $0.title
            }
        }
    }
}


    
    
