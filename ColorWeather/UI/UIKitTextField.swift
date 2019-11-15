//
//  UIKitTextField.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 11/15/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import UIKit

/// Adds a completion handler to UITextField that is triggered when there is a change in text.
class UIKitTextField: UITextField, UITextFieldDelegate {
    
    /// Used to communicate the change in text to the text field that conforms to UIViewRepresentable.
    var textFieldDidChange: ((String) -> Void)?
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let oldValue = textField.text as NSString? {
            let newValue = oldValue.replacingCharacters(in: range, with: string)
            textFieldDidChange?(newValue as String)
            return true
        }
        return false
    }
}
