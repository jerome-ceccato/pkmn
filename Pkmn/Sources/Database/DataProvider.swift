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
    lazy var species: [PokemonSpecies] = db.species
    lazy var pokemon: [Pokemon] = db.pokemon
    lazy var evolutionChains: [Int] = db.evolutionChains
    
    // Type efficacy mapping

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
    
    // Pokemon indexing
    
    lazy var speciesEvolutionChainMapping: [Int: [PokemonSpecies]] = {
        var mapping = [Int: [PokemonSpecies]]()
        species.forEach { item in
            mapping[item.evolutionChainIdentifier, default: []].append(item)
        }
        return mapping
    }()

    lazy var pokemonSpeciesMapping: [Int: [Pokemon]] = {
        var mapping = [Int: [Pokemon]]()
        pokemon.forEach { item in
            mapping[item.speciesIdentifier, default: []].append(item)
        }
        return mapping
    }()
}
