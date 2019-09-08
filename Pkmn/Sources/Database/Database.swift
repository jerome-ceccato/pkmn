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
    let tablePokemon = Table("pokemon")
    let tableEvolutionChains = Table("evolution_chains")
    let tableForms = Table("pokemon_forms")
    
    let columnId = Expression<Int>("id")
    let columnIdentifier = Expression<String>("identifier")
    let columnDamageTypeId = Expression<Int>("damage_type_id")
    let columnTargetTypeId = Expression<Int>("target_type_id")
    let columnDamageFactor = Expression<Int>("damage_factor")
    let columnSpeciesId = Expression<Int>("species_id")
    let columnEvolutionChainId = Expression<Int>("evolution_chain_id")
    let columnFormIdentifier = Expression<String?>("form_identifier")
    let columnPokemonId = Expression<Int>("pokemon_id")
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
            PokemonSpecies(identifier: species[columnId],
                           evolutionChainIdentifier: species[columnEvolutionChainId],
                           name: species[columnIdentifier])
        }
    }
}

// Pokemon
extension Database {
    var evolutionChains: [Int] {
        return select(tableEvolutionChains) { chain in
            chain[columnId]
        }
    }

    var pokemon: [Pokemon] {
        return select(tablePokemon) { pokemon in
            Pokemon(identifier: pokemon[columnId],
                    speciesIdentifier: pokemon[columnSpeciesId],
                    name: pokemon[columnIdentifier])
        }
    }
}

// Forms
extension Database {
    var forms: [PokemonForm] {
        return select(tableForms) { form in
            PokemonForm(identifier: form[columnId],
                        pokemonIdentifier: form[columnPokemonId],
                        name: form[columnIdentifier],
                        formIdentifier: form[columnFormIdentifier] ?? "")
        }
    }
}
