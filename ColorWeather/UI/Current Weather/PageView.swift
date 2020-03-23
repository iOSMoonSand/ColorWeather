//
//  PageView.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/19/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

// TODO: Rename to something more specific.

struct PageView: View {
    
    @EnvironmentObject var userSettings: UserSettings
    @State var index = 0
    @State private var shouldShowDetailView = false
    
    var searchCompleter = CitySearchCompleter()
    
    var body: some View {
        
        ZStack {
            
            if !userSettings.cities.isEmpty {
                PageController(userSettings.cities,
                               currentPage: $index) { index, city in
                                CurrentWeatherView(city: city)
                                    .environmentObject(self.userSettings)
                }
                .edgesIgnoringSafeArea(.all)
            } else {
                
                LinearGradient(gradient: Gradient(colors:
                    [ColorConstants.settingsGradient.start,
                     ColorConstants.settingsGradient.end]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                Button(action: {
                    self.shouldShowDetailView.toggle()
                }) {
                    Text("Tap to add a new city.")
                        .italic()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .foregroundColor(Color(red: 250/255,
                                               green: 250/255,
                                               blue: 250/255))
                        .font(.system(size: 20, weight: .bold, design: .default))
                    
                }
            }
            
            VStack {
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        self.shouldShowDetailView.toggle()
                    }) {
                        Image(UIConstants.Shared.Assets.menu)
                            .resizable()
                            .renderingMode(.original)
                    }
                    .sheet(isPresented: self.$shouldShowDetailView) {
                        CitySearchView(isPresented: self.$shouldShowDetailView, currentPage: self.$index)
                            .environmentObject(self.userSettings)
                            .environmentObject(self.searchCompleter)
                    }
                    .frame(width: 25,
                           height: 25,
                           alignment: .center)
                        .shadow(radius: 3)
                        .opacity(0.85)
                        .padding(EdgeInsets(top: 10,
                                            leading: 0,
                                            bottom: 0,
                                            trailing: 20))
                }
                
                Spacer()
            }
        }
    }
}

struct PageView_Preview: PreviewProvider {
    
    static var previews: some View {
        PageView()
    }
}
