//
//  DataProvider.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 25/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class DataProvider {
    private let db: Database
    
    init(db: Database) {
        self.db = db
    }
    
    lazy var types: [PokemonType] = db.types
    
    private lazy var typeEfficacy: [PokemonTypeEfficacy] = db.typeEfficacy
    
    lazy var typeEfficacyAttackMapping: PokemonTypeEfficacyMapping = {
        var mapping = [Int: [Int: Int]]()
        typeEfficacy.forEach { row in
            mapping[row.damageTypeIdentifier, default: [:]][row.targetTypeIdentifier] = row.damageFactor
        }
        
        return PokemonTypeEfficacyMapping(mapping: mapping)
    }()
    
    lazy var typeEfficacyDefenceMapping: PokemonTypeEfficacyMapping = {
        var mapping = [Int: [Int: Int]]()
        typeEfficacy.forEach { row in
            mapping[row.targetTypeIdentifier, default: [:]][row.damageTypeIdentifier] = row.damageFactor
        }
        
        return PokemonTypeEfficacyMapping(mapping: mapping)
    }()
}
