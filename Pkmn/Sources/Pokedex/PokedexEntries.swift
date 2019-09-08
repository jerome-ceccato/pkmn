//
//  PokedexEntries.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 17/08/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import Foundation

// A pokemon row
struct PokedexEntry {
    let pokemon: Pokemon
    let species: PokemonSpecies
    let forms: [PokemonForm]
}

// An evolution chain
struct PokedexSection {
    let chainIdentifier: Int
    let species: [PokemonSpecies]
    let entries: [PokedexEntry]
    
    init(dataProvider: DataProvider, chainIdentifier: Int) {
        self.chainIdentifier = chainIdentifier
        
        self.species = dataProvider.speciesEvolutionChainMapping[chainIdentifier] ?? []
        let pokemonEntries: [[PokedexEntry]] = self.species.map({ item in
            let allPokemon: [Pokemon] = dataProvider.pokemonSpeciesMapping[item.identifier] ?? []
            return allPokemon.map({ pokemon in PokedexEntry(pokemon: pokemon,
                                                            species: item,
                                                            forms: dataProvider.pokemonFormMapping[pokemon.identifier] ?? []) })
        })
        self.entries = pokemonEntries.flatMap { $0 }
    }
}

// All the grouped pokedex
class PokedexEntries {
    let sections: [PokedexSection]

    init(dataProvider: DataProvider) {
        self.sections = dataProvider.evolutionChains.map { chainId in
            PokedexSection(dataProvider: dataProvider, chainIdentifier: chainId)
        }
    }
}
