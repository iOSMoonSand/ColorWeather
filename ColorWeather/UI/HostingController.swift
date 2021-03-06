//
//  HostingController.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/27/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

class HostingController<Content>: UIHostingController<Content> where Content : View {
    
    var viewDidAppearHandler: (() -> Void)?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // TODO: Use this method to update display when swiping instead of buggy .onAppear.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearHandler?()
    }
}
