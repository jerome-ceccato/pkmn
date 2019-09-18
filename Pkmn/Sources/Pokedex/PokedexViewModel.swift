//
//  PokedexViewModel.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 17/08/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

enum PokedexDisplayStyle {
    case table
    case imageCollection
}

class PokedexViewModel {
    private let dataProvider: DataProvider
    private lazy var pokedexData = PokedexEntries(dataProvider: dataProvider)
    
    var displayStyle = PokedexDisplayStyle.table
    
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
        switch displayStyle {
        case .table:
            return String(describing: PokedexRowCollectionViewCell.self)
        case .imageCollection:
            return String(describing: PokedexLargeImageCollectionViewCell.self)
        }
    }

    func cellSize(at indexPath: IndexPath, in collectionView: UICollectionView) -> CGSize {
        switch displayStyle {
        case .table:
            return CGSize(width: collectionView.bounds.size.width, height: 44)
        case .imageCollection:
            return CGSize(width: 64, height: 64)
        }
    }
}
