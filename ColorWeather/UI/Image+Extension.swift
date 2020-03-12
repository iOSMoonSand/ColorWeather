//
//  Image+Extension.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 03/11/20.
//  Copyright © 2020 iOS MoonSand. All rights reserved.
//

import SwiftUI

extension Image {
    
    func asThumbnail(with maxWidth: CGFloat = 30) -> some View {
        resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: maxWidth)
    }
}
