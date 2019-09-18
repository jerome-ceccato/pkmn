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
    let defaultForm: PokemonForm
    let forms: [PokemonForm]
}

// All the pokedex
class PokedexEntries {
    let entries: [PokedexEntry]

    init(dataProvider: DataProvider) {
        entries = dataProvider.pokemon.compactMap({ pokemon in
            if let species = dataProvider.speciesIdMapping[pokemon.speciesIdentifier],
                let forms = dataProvider.formFromPokemonMapping[pokemon.identifier],
                let defaultForm = forms.first(where: { $0.isDefault }) {
                let entry = PokedexEntry(pokemon: pokemon,
                                         species: species,
                                         defaultForm: defaultForm,
                                         forms: forms)

                if (PokedexEntries.shouldBeIncluded(entry: entry)) {
                    return entry
                }
            }
            return nil
        }).sorted(by: { (a, b) in a.defaultForm.order < b.defaultForm.order })
    }
}

// Utils
private extension PokedexEntries {
    static func shouldBeIncluded(entry: PokedexEntry) -> Bool {
        if (entry.pokemon.isDefault) {
            return true
        } else if entry.defaultForm.isMega {
            return true
        }
        return false
    }
}
