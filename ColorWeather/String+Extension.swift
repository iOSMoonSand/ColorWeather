//
//  String+Extension.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/27/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

extension StringProtocol {
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}
