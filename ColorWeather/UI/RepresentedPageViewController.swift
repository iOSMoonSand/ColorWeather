//
//  RepresentedPageViewController.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/19/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI
import UIKit

/// Representation of a UIPageViewController in SwiftUI.
struct RepresentedPageViewController: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIPageViewController
    
    var controllers: [UIViewController]
    
    func makeCoordinator() -> RepresentedPageViewController.Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<RepresentedPageViewController>) -> RepresentedPageViewController.UIViewControllerType {
        
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        
        pageViewController.setViewControllers([controllers[0]],
                                              direction: .forward,
                                              animated: false)
        
        return pageViewController
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: UIViewControllerRepresentableContext<RepresentedPageViewController>) {
        
        // TODO: See what this is used for.
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource {
        
        var parent: RepresentedPageViewController
        
        init(_ pageViewController: RepresentedPageViewController) {
            self.parent = pageViewController
        }
        
        // MARK: UIPageViewControllerDataSource Methods
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            
            if index == 0 {
                return parent.controllers.last
            }
            
            return parent.controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            
            if index + 1 == parent.controllers.count {
                return parent.controllers.first
            }
            
            return parent.controllers[index + 1]
        }
    }
}

