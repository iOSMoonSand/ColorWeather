//
//  CitySearchView.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 09/17/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

struct CitySearchView: View {
    
    // MARK: - Stateful Properties
    
    // MARK: Public
    @ObservedObject var searchCompleter: CitySearchCompleter
    
    // MARK: Private
    @State private var searchFragment = String()
    
    // MARK: - View Body
    var body: some View {
        VStack {
            // TODO: Clean up test code.
            RepresentedTextField(text: $searchFragment, placeHolder: "Enter city name") { fragment in
                self.searchCompleter.search(with: fragment)
            }
            .disableAutocorrection(true)
            
            // TODO: Clean up test code, UI is broken.
            NavigationView {
                List {
                    ForEach(searchCompleter.results, id: \.self) { searchResult in
                        NavigationLink(destination: CurrentWeatherView(city: searchResult)) {
                            Text(searchResult)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let searchCompleter = CitySearchCompleter()

    static var previews: some View {
        CitySearchView(searchCompleter: searchCompleter)
    }
}
