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
