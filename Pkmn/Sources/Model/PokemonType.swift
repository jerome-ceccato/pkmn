//
//  PokemonType.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 25/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

struct PokemonType {
    let identifier: Int
    let name: String
}

// Localization
extension PokemonType {
    var localizedName: String {
        return pkmnLocalized(typeName: self)
    }
}

struct PokemonTypeEfficacy {
    let damageTypeIdentifier: Int
    let targetTypeIdentifier: Int
    let damageFactor: Int
}

struct PokemonTypeEfficacyMapping {
    typealias TypeIdentifier = Int
    typealias DamageFactor = Int
    
    let mapping: [TypeIdentifier: [TypeIdentifier: DamageFactor]]
}

extension PokemonTypeEfficacy {
    enum Category {
        case doubleEffective
        case effective
        case normal
        case resistant
        case doubleResistant
        case immune
    }
}

extension PokemonTypeEfficacy.Category {
    init(damageFactor: Int) {
        switch damageFactor {
        case 0:
            self = .immune
        case 50:
            self = .resistant
        case 200:
            self = .effective
        default:
            self = .normal
        }
    }
    
    init(category1: PokemonTypeEfficacy.Category, category2: PokemonTypeEfficacy.Category) {
        switch (category1, category2) {
        case (.effective, .effective):
            self = .doubleEffective
        case (.effective, .normal), (.normal, .effective):
            self = .effective
        case (.resistant, .normal), (.normal, .resistant):
            self = .resistant
        case (.resistant, .resistant):
            self = .doubleResistant
        case (.immune, _), (_, .immune):
            self = .immune
        default:
            self = .normal
        }
    }
}

struct PokemonTypes {
    let primaryType: PokemonType
    let secondaryType: PokemonType?
}

struct PokemonRawType {
    let pokemonIdentifier: Int
    let typeIdentifier: Int
    let slot: Int
}
