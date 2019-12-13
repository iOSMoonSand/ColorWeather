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
    
    //TODO: Need to dynamically choose background color.
    var body: some View {
        
        let views: [CurrentWeatherView] = cityData.cities.map {
            CurrentWeatherView(city: $0)
        }
        
        let viewControllers: [HostingController<CurrentWeatherView>] = views.map {
            let controller = HostingController(rootView: $0)
            controller.viewDidAppearHandler = {
                controller.rootView.updateViewData()
            }
            controller.view.backgroundColor = UIColor.clear
            return controller
        }
        
        let representedPageVC = RepresentedPageViewController(controllers: viewControllers,
                                                    shouldResetControllers: cityData.shouldRefreshControllers)
            .background(
                LinearGradient(gradient: Gradient(colors:
                    [ColorConstants.Sky.Day.clearGradientStart,
                     ColorConstants.Sky.Day.clearGradientEnd]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
        )
        
        cityData.shouldRefreshControllers = false
        
        return representedPageVC
    }
}

struct PageView_Preview: PreviewProvider {

    static var previews: some View {
        PageView()
    }
}
