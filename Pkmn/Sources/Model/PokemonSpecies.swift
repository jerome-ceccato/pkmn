//
//  PokemonSpecies.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 03/08/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

struct PokemonSpecies {
    let identifier: Int
    let evolutionChainIdentifier: Int
    let name: String
}

// Localization
extension PokemonSpecies {
    var localizedName: String {
        return pkmnLocalized(speciesName: self)
    }
}
