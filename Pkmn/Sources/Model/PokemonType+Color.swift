//
//  PokemonType+Color.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 18/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

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
    
    static let unknownColorLight: UInt32 = 0x9DC1B7
    static let colorMappingLight: [String: UInt32] = [
        "bug": 0xC6D16E,
        "dark": 0xA29288,
        "dragon": 0xA27DFA,
        "electric": 0xFAE078,
        "fairy": 0xF4BDC9,
        "fighting": 0xD67873,
        "fire": 0xF5AC78,
        "flying": 0xC6B7F5,
        "ghost": 0xA292BC,
        "grass": 0xA7DB8D,
        "ground": 0xEBD69D,
        "ice": 0xBCE6E6,
        "normal": 0xC6C6A7,
        "poison": 0xC183C1,
        "psychic": 0xFA92B2,
        "rock": 0xD1C17D,
        "steel": 0xD1D1E0,
        "water": 0x9DB7F5
    ]
    
    static let unknownColorDark: UInt32 = 0x44685E
    static let colorMappingDark: [String: UInt32] = [
        "bug": 0x6D7815,
        "dark": 0x49392F,
        "dragon": 0x4924A1,
        "electric": 0xA1871F,
        "fairy": 0x9B6470,
        "fighting": 0x7D1F1A,
        "fire": 0x9C531F,
        "flying": 0x6D5E9C,
        "ghost": 0x493963,
        "grass": 0x4E8234,
        "ground": 0x927D44,
        "ice": 0x638D8D,
        "normal": 0x6D6D4E,
        "poison": 0x682A68,
        "psychic": 0xA13959,
        "rock": 0x786824,
        "steel": 0x787887,
        "water": 0x445E9C
    ]
    
    func color() -> UIColor {
        let rawColor = PokemonType.colorMapping[name] ?? PokemonType.unknownColor
        return UIColor(hexValue: rawColor)
    }
    
    func lightColor() -> UIColor {
        let rawColor = PokemonType.colorMappingLight[name] ?? PokemonType.unknownColorLight
        return UIColor(hexValue: rawColor)
    }
    
    func darkColor() -> UIColor {
        let rawColor = PokemonType.colorMappingDark[name] ?? PokemonType.unknownColorDark
        return UIColor(hexValue: rawColor)
    }
}
