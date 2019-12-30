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
    @State private var isSearching = false
    @State private var farenheitUnits = true
    
    // MARK: - View Body
    var body: some View {
        
        let cities: [SettingsAddedCity] = self.cityData.cities.map { SettingsAddedCity(cityName: $0) }
        
        let vStack = VStack(spacing: 6) {
            
            Text("Add New")
                .font(.system(size: 26, weight: .bold, design: .default))
                .foregroundColor(Color(red: 250/255,
                                       green: 250/255,
                                       blue: 250/255))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .top], 20)
            
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
                    
                    RepresentedTextField(isEditing: $isSearching,
                                         placeHolder: "Enter city name") { fragment in
                                            
                                            self.searchCompleter.search(with: fragment)
                    }
                    .disableAutocorrection(true)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 40,
                           maxHeight: 40)
                        .onTapGesture {
                            if !self.isSearching {
                                self.isSearching.toggle()
                            }
                    }
                }
                    
                .padding([.leading, .trailing], 10)
                .background(Color(red: 250/255,
                                  green: 250/255,
                                  blue: 250/255))
                    .cornerRadius(10)
                
                Button(action: {
                    if self.isSearching {
                        self.isSearching.toggle()
                    } else {
                        self.isPresented = false
                    }
                }) {
                    if self.isSearching {
                        Text("Cancel")
                    } else {
                        Text("Close")
                    }
                }
                
            }
            .foregroundColor(Color(red: 250/255,
                                   green: 250/255,
                                   blue: 250/255))
                .padding([.leading, .trailing, .bottom], 20)
            
            if self.isSearching {
                
                CitySuggestionsListView(suggestions: searchCompleter.results, isPresented: self.$isPresented)
                    .environmentObject(self.cityData)
                
            } else {
                
                List {
                    Section(header: Text("MY CITIES")
                        .frame(height: 50)
                        .foregroundColor(Color(red: 113/255,
                                               green: 117/255,
                                               blue: 123/255))
                        .font(.system(size: 14, weight: .medium))
                    ) {
                        ForEach(cities, id: \.id) { city in
                            SettingsAddedCityRow(addedCity: city)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    
                    
                    Section(header: Text("SETTINGS")
                        .frame(height: 50)
                        .foregroundColor(Color(red: 113/255,
                                               green: 117/255,
                                               blue: 123/255))
                        .font(.system(size: 14, weight: .medium))
                    ) {
                        HStack {
                            if farenheitUnits {
                                Text("Temperature units are now in Farenheit.")
                                .foregroundColor(Color(red: 64/255,
                                                       green: 64/255,
                                                       blue: 64/255))
                                .padding([.leading], 10)
                                .padding([.top, .bottom], 10)
                            } else {
                                Text("Temperature units are now in Celcius.")
                                .foregroundColor(Color(red: 64/255,
                                                       green: 64/255,
                                                       blue: 64/255))
                                .padding([.leading], 10)
                                .padding([.top, .bottom], 10)
                            }
                            
                            
                            Toggle(isOn: $farenheitUnits) {
                                Text("")
                            }.padding()
                        }
                        
                    }
                }
                .onAppear() {
                    // Remove only extra separators below the list.
                    UITableView.appearance().tableFooterView = UIView()
                }
                .onDisappear() {
                    // Since we don't want the customization for all table views
                    // we undo it when we're finished with this screen.
                    UITableView.appearance().tableFooterView = nil
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors:
                [ColorConstants.settingsGradientStart,
                 ColorConstants.settingsGradientEnd]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
        )
        
        return vStack
    }
    
    func deleteItems(at offsets: IndexSet) {
        cityData.cities.remove(atOffsets: offsets)
    }
}


struct ContentView_Previews: PreviewProvider {
    
    @State static var isPresented = true
    
    static var previews: some View {
        CitySearchView(isPresented: $isPresented)
    }
}
