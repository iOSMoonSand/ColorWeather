//
//  CitySuggestionsListView.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 12/11/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

struct CitySuggestionsListView: View {
    
    @EnvironmentObject var userSettings: UserSettings
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
                        self.userSettings.cities.append(suggestion)
                        UserDefaults.standard.set(self.userSettings.cities, forKey: "Cities")
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
