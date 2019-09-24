//
//  PokedexEntryViewModel.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 18/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokedexEntryViewModel {
    private let entry: PokedexEntry

    init(entry: PokedexEntry) {
        self.entry = entry
    }
}

extension PokedexEntryViewModel {
    var pokedexNumber: String {
        return String(format: "%03d", entry.species.identifier)
    }

    var name: String {
        if entry.species.identifier == entry.pokemon.identifier {
            return entry.species.localizedName
        } else if entry.defaultForm.formIdentifier == "alola" {
            return "\(entry.species.localizedName) \(entry.defaultForm.localizedName)"
        } else {
            return entry.defaultForm.localizedName
        }
    }
    
    var types: PokemonTypes {
        return entry.types
    }
    
    var iconImage: UIImage? {
        return UIImage(named: "icon-\(entry.resourceIdentifier)")
    }
    
    var mainImage: UIImage? {
        return UIImage(named: "main-\(entry.resourceIdentifier)")
    }
    
    var artImage: UIImage? {
        return UIImage(named: "art-\(entry.resourceIdentifier)")
    }
}
