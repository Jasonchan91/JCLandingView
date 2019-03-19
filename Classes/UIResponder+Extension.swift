//
//  UIResponder+Extension.swift
//  JCLandingView
//
//  Created by Jason Chan on 11/12/18.
//

import UIKit

weak var sharedFirstResponder: UIResponder? = nil

extension UIResponder {
    
    class func findFirstResponder() -> UIResponder? {
        sharedFirstResponder = nil
        UIApplication.shared.sendAction(#selector(captureFirstResponder), to: nil, from: nil, for: nil)
        return sharedFirstResponder
    }
    
    @objc func captureFirstResponder() {
        sharedFirstResponder = self
    }
}

