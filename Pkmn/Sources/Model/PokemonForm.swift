//
//  PokemonForm.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 18/08/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import Foundation

struct PokemonForm {
    let identifier: Int
    let pokemonIdentifier: Int
    let name: String
    let formIdentifier: String
}

// Localization
extension PokemonForm {
    var localizedName: String {
        return pkmnLocalized(formName: self)
    }
}
