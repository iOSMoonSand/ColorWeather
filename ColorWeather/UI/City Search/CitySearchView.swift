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
    @EnvironmentObject var cityData: CityData
    @ObservedObject var searchCompleter = CitySearchCompleter()
    @Binding var isPresented: Bool
    
    // MARK: Private
    @State private var searchFragment = String()
    @State private var isSearching = false
    
    // MARK: - View Body
    var body: some View {
        
        VStack {
            
            HStack{
                HStack {
                    
                    Image("search")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(red: 200/255,
                                               green: 200/255,
                                               blue: 200/255))
                        .aspectRatio(1, contentMode: .fit)
                        
                        .frame(width: 18,
                               height: 18,
                               alignment: .center)
                    
                    
                    
                    RepresentedTextField(text: $searchFragment, placeHolder: "Enter city name") { fragment in
                        self.searchCompleter.search(with: fragment)
                    }
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 40,
                           maxHeight: 40)
                        .disableAutocorrection(true)
                        .onTapGesture {
                            
                            self.isSearching.toggle()
                    }
                }
                .padding([.leading, .trailing], 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                
                Button(action: {
                    self.isPresented = false
                }) {
                    Text("Cancel")
                }
                
            }.padding([.top, .leading, .trailing], 20)
            
            
            
            if self.isSearching {
                CitySuggestionsListView(suggestions: searchCompleter.results, isPresented: self.$isPresented)
                    .environmentObject(self.cityData)
            } else {
                CitySuggestionsListView(suggestions: searchCompleter.results, isPresented: self.$isPresented)
                    .hidden()
                    .environmentObject(self.cityData)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    @State static var isPresented = true
    
    static var previews: some View {
        CitySearchView(isPresented: $isPresented)
    }
}
