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
    
    @Binding var currentPage: Int
    
    var controllers: [UIViewController]
    var coordinator: PagesCoordinator?
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        
        let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal)
        pageViewController.dataSource = coordinator
        pageViewController.delegate = coordinator
        pageViewController.view.backgroundColor = .clear
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        
        pageViewController.dataSource = coordinator
        pageViewController.delegate = coordinator
        
        pageViewController.setViewControllers([controllers[currentPage]],
                                              direction: .forward,
                                              animated: false)
    }
}


class PagesCoordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var parent: RepresentedPageViewController
    
    init(_ pageViewController: RepresentedPageViewController) {
        self.parent = pageViewController
    }
    
    // MARK: UIPageViewControllerDataSource Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = parent.controllers.firstIndex(of: viewController) else {
            return nil
        }
        
        return index == 0 ? nil : parent.controllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = parent.controllers.firstIndex(of: viewController) else {
            return nil
        }
        
        return index == parent.controllers.count - 1 ? nil : parent.controllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if
            completed,
            let visibleViewController = pageViewController.viewControllers?.first,
            let index = parent.controllers.firstIndex(of: visibleViewController) {
            parent.currentPage = index
        }
    }
}

