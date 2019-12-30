//
//  UIApplication+Extension.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 12/29/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
