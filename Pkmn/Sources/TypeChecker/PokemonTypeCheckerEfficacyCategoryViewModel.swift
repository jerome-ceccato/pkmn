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
    var multiplierDisplayString: String {
        return "x\(multiplierString)"
    }
    
    var multiplierString: String {
        switch category {
        case .doubleEffective:
            return pkmnLocalizedNumber(4)
        case .effective:
            return pkmnLocalizedNumber(2)
        case .normal:
            return pkmnLocalizedNumber(1)
        case .resistant:
            return pkmnLocalizedNumber(0.5)
        case .doubleResistant:
            return pkmnLocalizedNumber(0.25)
        case .immune:
            return pkmnLocalizedNumber(0)
        }
    }
    
    var tintColor: UIColor {
        switch category {
        case .doubleEffective, .effective:
            return UIColor(hexValue: 0xDC143C)
        case .resistant, .doubleResistant:
            return UIColor(hexValue: 0x4169E1)
        case .normal, .immune:
            return UIColor(hexValue: 0xA9A9A9)
        }
    }
    
    var multiplierFont: UIFont {
        let fontSize: CGFloat = 17
        let smallerFontSize: CGFloat = 15

        switch category {
        case .doubleEffective:
            return UIFont.systemFont(ofSize: fontSize, weight: .black)
        case .effective:
            return UIFont.systemFont(ofSize: fontSize, weight: .bold)
        case .normal, .resistant, .doubleResistant, .immune:
            return UIFont.systemFont(ofSize: smallerFontSize, weight: .regular)
        }
    }
}
