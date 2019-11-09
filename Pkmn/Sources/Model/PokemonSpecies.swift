//
//  PokemonSpecies.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 03/08/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

struct PokemonSpecies {
    let identifier: Int
    let evolutionChainIdentifier: Int
    let previousSpeciesId: Int?
    let name: String
    
    let hasGenderDifferences: Bool
}

//id          identifier  generation_id  evolves_from_species_id  evolution_chain_id  color_id    shape_id    habitat_id  gender_rate  capture_rate  base_happiness  is_baby     hatch_counter  has_gender_differences  growth_rate_id  forms_switchable  order       conquest_order

// Localization
extension PokemonSpecies {
    var localizedName: String {
        return pkmnLocalized(speciesName: self)
    }
}
