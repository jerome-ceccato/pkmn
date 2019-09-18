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
    var name: String {
        return entry.species.localizedName
    }
    
    var subtitle: String {
        if entry.species.identifier == entry.pokemon.identifier {
            return ""
        } else if let form = entry.forms.first {
            return form.localizedName
        } else {
            return "???"
        }
    }
    
    var iconImage: UIImage? {
        if let image = UIImage(named: "icon-\(entry.pokemon.identifier)") {
            return image
        } else if let form = entry.forms.first,
            let image = UIImage(named: "icon-\(entry.species.identifier)-\(form.formIdentifier)") {
            return image
        } else {
            return nil
        }
    }
}
