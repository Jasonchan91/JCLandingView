//
//  UIColor+Extension.swift
//  Dynamic View
//
//  Created by Jason Chan on 22/1/19.
//  Copyright © 2019 Jason Chan. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var textColor: UIColor {
        return UIColor.RGBA(red: 74, green: 74, blue: 74, alpha: 74)
    }
    
    static var tintColor: UIColor {
        return UIColor.RGBA(red: 56, green: 147, blue: 217, alpha: 1)
    }
    
    static func RGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

extension UIFont {
    
    static func demiBoldDefaultFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: size)!
    }
    
    static func mediumDefaultFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Medium", size: size)!
    }
}
