//
//  PokemonTypeCheckerScenarioButton.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 29/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonTypeCheckerScenarioButton: UIButton {
    @IBOutlet weak var iconImageView: UIImageView?
    @IBOutlet weak var textLabel: UILabel?
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            guard oldValue != self.isHighlighted else {
                return
            }
            
            performStateTransitionAnimation {
                if (self.isHighlighted) {
                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                } else {
                    self.transform = CGAffineTransform.identity
                }
            }
        }
    }

    private func updateSelectedState() {
        let selectedColor = UIColor.systemDefaultTint

        if self.isSelected {
            backgroundColor = selectedColor
            layer.borderWidth = 0
            iconImageView?.tintColor = .white
            textLabel?.textColor = .white

        } else {
            backgroundColor = .clear
            layer.borderWidth = 1
            layer.borderColor = selectedColor.cgColor
            iconImageView?.tintColor = selectedColor
            textLabel?.textColor = selectedColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 8
        layer.masksToBounds = true
        iconImageView?.image = iconImageView?.image?.withRenderingMode(.alwaysTemplate)

        updateSelectedState()
    }
}

private extension PokemonTypeCheckerScenarioButton {
    func performStateTransitionAnimation(with animations: @escaping () -> Void) {
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: [.beginFromCurrentState, .allowUserInteraction],
                       animations: animations,
                       completion: nil)
    }
}
