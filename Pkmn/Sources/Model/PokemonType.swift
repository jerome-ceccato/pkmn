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

extension PokemonType {
    static let unknownColor: UInt32 = 0x68A090
    static let colorMapping: [String: UInt32] = [
        "bug": 0xA8B820,
        "dark": 0x705848,
        "dragon": 0x7038F8,
        "electric": 0xF8D030,
        "fairy": 0xEE99AC,
        "fighting": 0xC03028,
        "fire": 0xF08030,
        "flying": 0xA890F0,
        "ghost": 0x705898,
        "grass": 0x78C850,
        "ground": 0xE0C068,
        "ice": 0x98D8D8,
        "normal": 0xA8A878,
        "poison": 0xA040A0,
        "psychic": 0xF85888,
        "rock": 0xB8A038,
        "steel": 0xB8B8D0,
        "water": 0x6890F0
    ]
    
    func color() -> UIColor {
        let rawColor = PokemonType.colorMapping[name] ?? PokemonType.unknownColor
        return UIColor(hexValue: rawColor)
    }
}
