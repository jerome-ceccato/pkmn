//
//  SeparatorView.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 20/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class SeparatorView: UIView {
    override func awakeFromNib() {
        for constraint in constraints {
            if (constraint.firstAttribute == .height || constraint.firstAttribute == .width) && constraint.constant == 1 {
                constraint.constant = 1.0 / UIScreen.main.scale
            }
        }
    }
}
