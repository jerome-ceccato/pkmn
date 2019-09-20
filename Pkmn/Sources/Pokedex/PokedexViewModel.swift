//
//  PokedexViewModel.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 17/08/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokedexViewModel {
    private let dataProvider: DataProvider
    private lazy var pokedexData = PokedexEntries(dataProvider: dataProvider)
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
}

extension PokedexViewModel {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(for section: Int) -> Int {
        return pokedexData.entries.count
    }
    
    func pokedexEntry(at indexPath: IndexPath) -> PokedexEntryViewModel {
        let entry = pokedexData.entries[indexPath.row]
        return PokedexEntryViewModel(entry: entry)
    }
    
    func entryCellIdentifier(at indexPath: IndexPath) -> String {
        return String(describing: PokedexTableViewCell.self)
    }
}
