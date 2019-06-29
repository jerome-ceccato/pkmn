//
//  UIView+Autolayout.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 26/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

struct OptionalInsets {
    var top: CGFloat?
    var bottom: CGFloat?
    var leading: CGFloat?
    var trailing: CGFloat?
    
    static let zero: OptionalInsets = OptionalInsets(top: 0, bottom: 0, leading: 0, trailing: 0)
}

extension UIView {
    func addSubview(_ view: UIView, pinnedToEdges edges: OptionalInsets) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        var newConstaints = [NSLayoutConstraint]()
        
        if let top = edges.top {
            newConstaints.append(topAnchor.constraint(equalTo: view.topAnchor, constant: top))
        }
        if let leading = edges.leading {
            newConstaints.append(leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading))
        }
        if let bottom = edges.bottom {
            newConstaints.append(bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottom))
        }
        if let trailing = edges.trailing {
            newConstaints.append(trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -trailing))
        }
        
        NSLayoutConstraint.activate(newConstaints)
    }
}
