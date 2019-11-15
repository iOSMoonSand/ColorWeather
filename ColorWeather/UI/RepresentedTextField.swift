//
//  RepresentedTextField.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/15/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import SwiftUI

struct RepresentedTextField: UIViewRepresentable {
    
    // MARK: - Stateful Properties
    
    // MARK: Public
    @Binding var text: String
    
    // MARK: - Stateless Properties
    
    // MARK: Public
    var placeHolder: String?
    var textFieldDidChange: ((String) -> Void)?
    
    // MARK: Private
    private let uiKitTextField = UIKitTextField()
    
    // MARK: - UIViewRepresentable Protocol Methods
    
    // We create our UITextfield and set its delegate property.
    func makeUIView(context: Context) -> UITextField {
        uiKitTextField.placeholder = placeHolder
        uiKitTextField.textFieldDidChange = textFieldDidChange
        uiKitTextField.delegate = uiKitTextField
        return uiKitTextField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<RepresentedTextField>) {
        // TODO: Not firing for changes in text field text. Is this a bug?
    }
}
