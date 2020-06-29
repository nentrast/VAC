//
//  UIView+Extension.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 01.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import UIKit

@IBDesignable
extension UIView {

    @IBInspectable var borderWidth: CGFloat  {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor  {
        get {
            return UIColor(cgColor: layer.borderColor ?? CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0))
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            clipsToBounds = newValue > 0
            layer.cornerRadius = newValue
        }
    }
}
