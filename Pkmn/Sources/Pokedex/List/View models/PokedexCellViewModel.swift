//
//  PokedexCellViewModel.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 29/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokedexCellViewModel {
    let entryViewModel: PokedexEntryViewModel
    let filter: String?

    init(entryViewModel: PokedexEntryViewModel,
         filter: String?) {
        self.entryViewModel = entryViewModel
        self.filter = filter
    }
}
