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
    
    @EnvironmentObject var cityData: CityData
    @State var index = 0
    @State private var shouldShowDetailView = false
    
    //TODO: Need to dynamically choose background color.
    var body: some View {
        
        ZStack {
            PageController(cityData.cities,
                           currentPage: $index) { index, city in
                           CurrentWeatherView(city: city)
            }
            
            VStack {
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                                        // TODO: Implement button action.
                                        self.shouldShowDetailView.toggle()
                                    }) {
                                        Image(UIConstants.Shared.Assets.menu)
                                            .resizable()
                                            .renderingMode(.original)
                                    }
                                    .sheet(isPresented: self.$shouldShowDetailView) {
                                        CitySearchView(isPresented: self.$shouldShowDetailView)
                                            .environmentObject(self.cityData)
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
