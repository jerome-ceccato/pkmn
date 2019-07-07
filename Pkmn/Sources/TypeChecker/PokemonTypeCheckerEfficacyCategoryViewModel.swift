//
//  PokemonTypeCheckerEfficacyCategoryViewModel.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 03/07/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonTypeCheckerEfficacyCategoryViewModel {
    private let category: PokemonTypeEfficacy.Category
    
    init(category: PokemonTypeEfficacy.Category) {
        self.category = category
    }
}

extension PokemonTypeCheckerEfficacyCategoryViewModel {
    var displayString: String {
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
    
    var multiplierDisplayString: String {
        return "x\(multiplierString)"
    }
    
    var multiplierString: String {
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
    
    var tintColor: UIColor {
        switch category {
        case .doubleEffective:
            return UIColor(hexValue: 0xDC143C)
        case .effective:
            return UIColor(hexValue: 0xF08080)
        case .resistant:
            return UIColor(hexValue: 0x6495ED)
        case .doubleResistant:
            return UIColor(hexValue: 0x4169E1)
        case .normal, .immune:
            return UIColor(hexValue: 0xA9A9A9)
        }
    }
    
    var visualIndicatorWidthMultiplier: CGFloat {
        let baseMultiplier: CGFloat = 0.5
        
        switch category {
        case .doubleEffective:
            return baseMultiplier
        case .effective:
            return baseMultiplier / 2
        case .normal:
            return 0
        case .resistant:
            return baseMultiplier / 4
        case .doubleResistant:
            return baseMultiplier / 8
        case .immune:
            return 0
        }
    }
}
