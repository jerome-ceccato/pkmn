//
//  PokemonEvolution.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 04/11/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

struct PokemonEvolution {
    let speciesIdentifier: Int
    let evolutionTriggerIdentifier: Int
    let minimumLevel: Int
}

class PokemonEvolutionChain {
    struct Evolution {
        let requirement: PokemonEvolution
        let next: PokemonEvolutionChain
    }

    let species: PokemonSpecies
    var preEvolution: PokemonEvolutionChain?
    var evolutions: [Evolution] = []
    
    init(species: PokemonSpecies) {
        self.species = species
    }
}

extension PokemonEvolutionChain {
    var firstEvolutionInChain: PokemonEvolutionChain {
        if let pre = preEvolution {
            return pre.firstEvolutionInChain
        } else {
            return self
        }
    }
    
    var orderedChain: [PokemonEvolutionChain] {
        return [self] + evolutions.flatMap { $0.next.orderedChain }
    }

    var numberOfSpeciesInChain: Int {
        return firstEvolutionInChain.orderedChain.count
    }
}
