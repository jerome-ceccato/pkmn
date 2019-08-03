//
//  Database.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 24/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import Foundation
import SQLite

class Database: DatabaseWrapper {
    let tableTypes = Table("types")
    let tableTypeEfficacy = Table("type_efficacy")
    let tableSpecies = Table("pokemon_species")
    
    let columnId = Expression<Int>("id")
    let columnIdentifier = Expression<String>("identifier")
    let columnDamageTypeId = Expression<Int>("damage_type_id")
    let columnTargetTypeId = Expression<Int>("target_type_id")
    let columnDamageFactor = Expression<Int>("damage_factor")
}

// Types
extension Database {
    var types: [PokemonType] {
        return select(tableTypes.filter(columnId < 10000)) { type in
            PokemonType(identifier: type[columnId], name: type[columnIdentifier])
        }
    }
    
    var typeEfficacy: [PokemonTypeEfficacy] {
        return select(tableTypeEfficacy) { row in
            PokemonTypeEfficacy(damageTypeIdentifier: row[columnDamageTypeId],
                                targetTypeIdentifier: row[columnTargetTypeId],
                                damageFactor: row[columnDamageFactor])
        }
    }
}

// Species
extension Database {
    var numberOfPokemon: Int {
        return count(tableSpecies)
    }
    
    var species: [PokemonSpecies] {
        return select(tableSpecies) { species in
            PokemonSpecies(identifier: species[columnId], name: species[columnIdentifier])
        }
    }
}
