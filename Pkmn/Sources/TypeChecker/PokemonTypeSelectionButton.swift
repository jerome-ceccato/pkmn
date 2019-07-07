//
//  PokemonTypeSelectionButton.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 28/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonTypeSelectionButton: UIButton {
    var type: PokemonType!
    
    convenience init(type: PokemonType) {
        self.init(type: .custom)
        
        self.type = type
        backgroundColor = type.color()

        setAttributedTitle(boldTitle(with: type.localizedName, color: .white), for: .normal)
        
        layer.cornerRadius = 8
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.2
    }
    
    private func boldTitle(with text: String, color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: [.font: UIFont.boldSystemFont(ofSize: 17),
                                                             .foregroundColor: color])
    }
    
    override var isHighlighted: Bool {
        didSet {
            guard oldValue != self.isHighlighted else {
                return
            }
            
            performStateTransitionAnimation {
                if (self.isHighlighted) {
                    self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                } else {
                    self.transform = CGAffineTransform.identity
                }
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            guard oldValue != self.isSelected else {
                return
            }
            
            performStateTransitionAnimation {
                if (self.isSelected) {
                    self.alpha = 0.3
                } else {
                    self.alpha = 1
                }
            }
        }
    }
}

private extension PokemonTypeSelectionButton {
    func performStateTransitionAnimation(with animations: @escaping () -> Void) {
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: [.beginFromCurrentState, .allowUserInteraction],
                       animations: animations,
                       completion: nil)
    }
}
