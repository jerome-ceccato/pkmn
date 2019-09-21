//
//  PokemonPageViewModel.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 21/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonPageViewModel {
    private let dataProvider: DataProvider
    private let entry: PokedexEntry
    
    let entryViewModel: PokedexEntryViewModel
    
    init(dataProvider: DataProvider, entry: PokedexEntry) {
        self.dataProvider = dataProvider
        self.entry = entry
        
        self.entryViewModel = PokedexEntryViewModel(entry: entry)
    }
}

// View controller
extension PokemonPageViewModel {
    var numberOfRows: Int {
        return 1
    }
    
    func cellIdentifier(for indexPath: IndexPath) -> String {
        return String(describing: PokemonPageHeaderTableViewCell.self)
    }
}

extension PokemonPageViewModel {
    var flavorText: String {
        return pkmnLocalized(speciesFlavorText: entry.species).replacingOccurrences(of: "\n", with: " ")
    }
}
