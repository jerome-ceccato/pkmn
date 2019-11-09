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
    let tableForms = Table("pokemon_forms")
    let tablePokemonTypes = Table("pokemon_types")
    let tableEvolutions = Table("pokemon_evolution")
    
    let columnId = Expression<Int>("id")
    let columnIdentifier = Expression<String>("identifier")
    let columnDamageTypeId = Expression<Int>("damage_type_id")
    let columnTargetTypeId = Expression<Int>("target_type_id")
    let columnDamageFactor = Expression<Int>("damage_factor")
    let columnSpeciesId = Expression<Int>("species_id")
    let columnEvolutionChainId = Expression<Int>("evolution_chain_id")
    let columnFormIdentifier = Expression<String?>("form_identifier")
    let columnPokemonId = Expression<Int>("pokemon_id")
    let columnIsDefault = Expression<Bool>("is_default")
    let columnIsMega = Expression<Bool>("is_mega")
    let columnOrder = Expression<Int>("order")
    let columnSlot = Expression<Int>("slot")
    let columnTypeId = Expression<Int>("type_id")
    let columnHasGenderDifferences = Expression<Bool>("has_gender_differences")
    let columnEvolvedSpeciesId = Expression<Int>("evolved_species_id")
    let columnEvolvesFromSpeciesId = Expression<Int?>("evolves_from_species_id")
    let columnEvolutionTriggerId = Expression<Int>("evolution_trigger_id")
    let columnMinimumLevel = Expression<Int?>("minimum_level")
}

// Types
extension Database {
    var types: [PokemonType] {
        return select(tableTypes) { type in
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
                           previousSpeciesId: species[columnEvolvesFromSpeciesId],
                           name: species[columnIdentifier],
                           hasGenderDifferences: species[columnHasGenderDifferences])
        }
    }
}

// Pokemon
extension Database {
    var pokemon: [Pokemon] {
        return select(tablePokemon) { pokemon in
            Pokemon(identifier: pokemon[columnId],
                    speciesIdentifier: pokemon[columnSpeciesId],
                    name: pokemon[columnIdentifier],
                    isDefault: pokemon[columnIsDefault])
        }
    }
}

// Pokemon types
extension Database {
    var pokemonRawType: [PokemonRawType] {
        return select(tablePokemonTypes) { types in
            PokemonRawType(pokemonIdentifier: types[columnPokemonId],
                           typeIdentifier: types[columnTypeId],
                           slot: types[columnSlot])
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
                        formIdentifier: form[columnFormIdentifier] ?? "",
                        isDefault: form[columnIsDefault],
                        isMega: form[columnIsMega],
                        order: form[columnOrder])
        }
    }
}

// Evolutions
extension Database {
    var evolutions: [PokemonEvolution] {
        return select(tableEvolutions) { evolution in
            PokemonEvolution(speciesIdentifier: evolution[columnEvolvedSpeciesId],
                             evolutionTriggerIdentifier: evolution[columnEvolutionTriggerId],
                             minimumLevel: evolution[columnMinimumLevel] ?? -1)
        }
    }
}
