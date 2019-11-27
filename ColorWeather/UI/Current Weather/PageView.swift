//
//  PageView.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/19/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

// TODO: Rename to something more specific.

struct PageView<Page: View>: View {
    
    var viewControllers: [HostingController<Page>]
    
    init(_ views: [Page]) {
        self.viewControllers = views.map {
            let controller = HostingController(rootView: $0)
            controller.view.backgroundColor = UIColor.clear
            return controller
            
        }
    }
    
    //TODO: Need to dynamically choose background color.
    var body: some View {
        RepresentedPageViewController(controllers: viewControllers)
            .background(
                LinearGradient(gradient: Gradient(colors:
                    [ColorConstants.Sky.Day.clearGradientStart,
                     ColorConstants.Sky.Day.clearGradientEnd]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
        )
    }
}

struct PageView_Preview: PreviewProvider {
    
    static let cities = ["Paris, France", "Santa Monica, CA, United States", "San Francisco, CA, United States"]
    
    static var previews: some View {
        PageView(cities.map {
            CurrentWeatherView(city: $0)
        })
    }
}
