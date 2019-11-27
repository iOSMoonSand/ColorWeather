//
//  HostingController.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/27/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

class HostingController<Content>: UIHostingController<Content> where Content : View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
