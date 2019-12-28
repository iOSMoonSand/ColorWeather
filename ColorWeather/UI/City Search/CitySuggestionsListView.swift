//
//  CitySuggestionsListView.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 12/11/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

struct CitySuggestionsListView: View {
    
    @EnvironmentObject var cityData: CityData
    @Binding var isPresented: Bool
    
    private var suggestions: [String]
    
    init(suggestions: [String], isPresented: Binding<Bool>) {
        self.suggestions = suggestions
        self._isPresented = isPresented
    }
    
    var body: some View {
        List {
            ForEach(suggestions, id: \.self) { suggestion in
                Text(suggestion)
                    .onTapGesture {
                        self.cityData.cities.append(suggestion)
                        self.isPresented = false
                }
            }
        }
    }
}

struct CitySuggestionsListView_Previews: PreviewProvider {
    
    @State static var isPresented = true
    
    static let suggestions = [
        "San Francisco, CA",
        "San Jose, CA",
        "San Fernando, CA"
    ]
    
    static var previews: some View {
        CitySuggestionsListView(suggestions: suggestions, isPresented: $isPresented)
    }
}
