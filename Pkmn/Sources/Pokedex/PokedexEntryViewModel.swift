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

private extension PokedexEntryViewModel {
    var resourceIdentifier: String {
        if entry.pokemon.isDefault {
            return "\(entry.pokemon.identifier)"
        } else {
            return "\(entry.species.identifier)-\(entry.defaultForm.formIdentifier)"
        }
    }
}

extension PokedexEntryViewModel {
    var pokedexNumber: String {
        return String(format: "%03d", entry.species.identifier)
    }

    var name: String {
        if entry.species.identifier == entry.pokemon.identifier {
            return entry.species.localizedName
        } else if let form = entry.forms.first {
            return form.localizedName
        } else {
            return "???"
        }
    }
    
    var types: PokemonTypes {
        return entry.types
    }
    
    var iconImage: UIImage? {
        return UIImage(named: "icon-\(resourceIdentifier)")
    }
    
    var mainImage: UIImage? {
        return UIImage(named: "main-\(resourceIdentifier)")
    }
}
