//
//  UIColor+Custom.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 28/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexValue: UInt32, alpha: CGFloat = 1) {
        self.init(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hexValue & 0xFF00) >> 8) / 255.0,
                  blue: CGFloat(hexValue & 0xFF) / 255.0,
                  alpha: alpha)
    }
}

extension UIColor {
    static let systemDefaultTint = UIView().tintColor!
}
