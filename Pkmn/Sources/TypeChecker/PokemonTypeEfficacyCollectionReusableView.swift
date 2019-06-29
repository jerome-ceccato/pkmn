//
//  PokemonTypeEfficacyCollectionReusableView.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 29/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonTypeEfficacyCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with category: PokemonTypeEfficacy.Category) {
        titleLabel.text = "\(efficacyString(category: category)) (x\(efficacyMultiplierString(category: category)))"
    }
}

private extension PokemonTypeEfficacyCollectionReusableView {
    func efficacyString(category: PokemonTypeEfficacy.Category) -> String {
        switch category {
        case .doubleEffective, .effective:
            return "Super effective"
        case .normal:
            return "Normal"
        case .resistant, .doubleResistant:
            return "Not very effective"
        case .immune:
            return "No effect"
        }
    }
    
    func efficacyMultiplierString(category: PokemonTypeEfficacy.Category) -> String {
        switch category {
        case .doubleEffective:
            return "4"
        case .effective:
            return "2"
        case .normal:
            return "1"
        case .resistant:
            return "0.5"
        case .doubleResistant:
            return "0.25"
        case .immune:
            return "0"
        }
    }
}
