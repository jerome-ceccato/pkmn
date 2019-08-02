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
        
        layer.cornerRadius = 8
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0, height: 3)

        updateState(selected: false)
    }
    
    private func updateState(selected: Bool) {
        if (selected) {
            backgroundColor = type.lightColor().withAlphaComponent(0.2)
            layer.shadowOpacity = 0
        } else {
            backgroundColor = type.color()
            layer.shadowOpacity = 0.2
        }
        setAttributedTitle(updatedAttributedTitle(selected: selected), for: .normal)
    }
    
    private func updatedAttributedTitle(selected: Bool) -> NSAttributedString {
        let fontWeight: UIFont.Weight = selected ? .black : .bold
        let color: UIColor = selected ? type.darkColor().withAlphaComponent(0.6) : .white
        
        return NSAttributedString(string: type.localizedName, attributes: [.font: UIFont.systemFont(ofSize: 17, weight: fontWeight),
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
                self.updateState(selected: self.isSelected)
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
