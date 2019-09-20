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
    lazy var forms: [PokemonForm] = db.forms
    lazy var pokemonRawTypes: [PokemonRawType] = db.pokemonRawType
    
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
    
    // Pokemon flat indexing
    
    lazy var speciesIdMapping: [Int: PokemonSpecies] = {
        var mapping = [Int: PokemonSpecies]()
        species.forEach { item in
            mapping[item.identifier] = item
        }
        return mapping
    }()
    
    lazy var typesIdMapping: [Int: PokemonType] = {
        var mapping = [Int: PokemonType]()
        types.forEach { item in
            mapping[item.identifier] = item
        }
        return mapping
    }()
    
    // Pokemon indexing
    
    lazy var speciesFromEvolutionChainMapping: [Int: [PokemonSpecies]] = {
        var mapping = [Int: [PokemonSpecies]]()
        species.forEach { item in
            mapping[item.evolutionChainIdentifier, default: []].append(item)
        }
        return mapping
    }()

    lazy var pokemonFromSpeciesMapping: [Int: [Pokemon]] = {
        var mapping = [Int: [Pokemon]]()
        pokemon.forEach { item in
            mapping[item.speciesIdentifier, default: []].append(item)
        }
        return mapping
    }()

    lazy var formFromPokemonMapping: [Int: [PokemonForm]] = {
        var mapping = [Int: [PokemonForm]]()
        forms.forEach { item in
            mapping[item.pokemonIdentifier, default: []].append(item)
        }
        return mapping
    }()
    
    lazy var typesFromPokemonMapping: [Int: PokemonTypes] = {
        var rawMapping = [Int: [Int : Int]]()
        pokemonRawTypes.forEach { item in
            rawMapping[item.pokemonIdentifier, default: [:]][item.slot] = item.typeIdentifier
        }

        var mapping = [Int: PokemonTypes]()
        rawMapping.keys.forEach { key in
            let firstTypeIdentifier = rawMapping[key]![1]!
            let secondTypeIdentifier = rawMapping[key]![2]
            mapping[key] = PokemonTypes(primaryType: typesIdMapping[firstTypeIdentifier]!,
                                        secondaryType: secondTypeIdentifier.map({ typesIdMapping[$0]! }))
        }
        return mapping
    }()
}
