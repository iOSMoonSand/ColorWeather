//
//  PageController.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 12/16/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

struct PageController<Data, Content>: View where Data: RandomAccessCollection, Content: View {
    
    @Binding var currentPage: Int
    var items: [Data.Element]
    
    private var template: (Int, Data.Element) -> Content
    
    init(_ items: Data, currentPage: Binding<Int>, template: @escaping (Int, Data.Element) -> Content) {
        self.items = items.map { $0 }
        self._currentPage = currentPage
        self.template = template
    }
    
    var body: some View {
        var pageViewController = RepresentedPageViewController(
            currentPage: $currentPage,
            controllers: (0..<items.count).map { i in
                
                let view = template(i, items[i])
                let hostingController = HostingController(rootView: view)
                hostingController.view.backgroundColor = .clear
                
                if let currentWeatherView = view as? CurrentWeatherView {
                    hostingController.viewDidAppearHandler = {
                        currentWeatherView.updateViewData()
                    }
                }
                
                return hostingController
            }
        )
        
        pageViewController.coordinator = PagesCoordinator(pageViewController)
        
        return pageViewController
    }
}
