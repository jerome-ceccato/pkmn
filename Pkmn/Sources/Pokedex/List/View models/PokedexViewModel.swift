//
//  PokedexViewModel.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 17/08/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

protocol PokedexViewModelDelegate {
    func reloadData()
}

class PokedexViewModel: NSObject {
    private let dataProvider: DataProvider
    private let pokedexData: PokedexEntries
    private var filteredEntries: [PokedexEntry]
    private var currentFilter: String?
    var delegate: PokedexViewModelDelegate?
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        self.pokedexData = PokedexEntries(dataProvider: dataProvider)
        self.filteredEntries = pokedexData.entries
    }
}

// View controller
extension PokedexViewModel {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(for section: Int) -> Int {
        return filteredEntries.count
    }
    
    func pokedexEntry(at indexPath: IndexPath) -> PokedexCellViewModel {
        let entry = filteredEntries[indexPath.row]
        return PokedexCellViewModel(entryViewModel: PokedexEntryViewModel(entry: entry),
                                    filter: currentFilter)
    }
    
    func entryCellIdentifier(at indexPath: IndexPath) -> String {
        return String(describing: PokedexTableViewCell.self)
    }
}

// Page
extension PokedexViewModel {
    func pageViewModel(at indexPath: IndexPath) -> PokemonPageViewModel {
        return PokemonPageViewModel(dataProvider: dataProvider,
                                    entry: filteredEntries[indexPath.row])
    }
}

// Filtering
extension PokedexViewModel: UISearchResultsUpdating {
    private func updateFilteredEntries(filter: String) {
        if filter.isEmpty {
            currentFilter = nil
            filteredEntries = pokedexData.entries
        } else {
            currentFilter = filter
            filteredEntries = pokedexData.entries.filter { entry in
                return PokedexEntryViewModel(entry: entry).name.localizedStandardContains(filter)
            }
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        updateFilteredEntries(filter: searchController.searchBar.text ?? "")
        delegate?.reloadData()
    }
}
