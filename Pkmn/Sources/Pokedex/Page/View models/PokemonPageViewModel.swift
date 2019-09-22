//
//  PokemonPageViewModel.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 21/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonPageViewModel {
    fileprivate let dataProvider: DataProvider
    fileprivate let entry: PokedexEntry
    
    let entryViewModel: PokedexEntryViewModel
    
    init(dataProvider: DataProvider, entry: PokedexEntry) {
        self.dataProvider = dataProvider
        self.entry = entry
        
        self.entryViewModel = PokedexEntryViewModel(entry: entry)
    }
    
    class _SubViewModel {
        fileprivate let pageViewModel: PokemonPageViewModel
        
        init(pageViewModel: PokemonPageViewModel) {
            self.pageViewModel = pageViewModel
        }
    }
    
    private enum PageCell {
        case header
        case sprites
    }

    private lazy var cells: [PageCell] = {
        return [.header, .sprites]
    }()
}

// View controller
extension PokemonPageViewModel {
    var numberOfRows: Int {
        return cells.count
    }
    
    func cellIdentifier(for indexPath: IndexPath) -> String {
        switch cells[indexPath.row] {
        case .header:
            return String(describing: PokemonPageHeaderTableViewCell.self)
        case .sprites:
            return String(describing: PokemonPageSpritesTableViewCell.self)
        }
    }
    
    func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .header:
            let cell = cell as! PokemonPageHeaderTableViewCell
            return cell.configure(with: HeaderViewModel(pageViewModel: self))
        case .sprites:
            let cell = cell as! PokemonPageSpritesTableViewCell
            return cell.configure(with: SpritesViewModel(pageViewModel: self))
        }
    }
}

// Header
extension PokemonPageViewModel {
    class HeaderViewModel: _SubViewModel {
        var name: String {
            return pageViewModel.entryViewModel.name
        }
        
        var types: PokemonTypes {
            return pageViewModel.entryViewModel.types
        }
        
        var backgroundImage: UIImage? {
            return pageViewModel.entryViewModel.mainImage
        }
        
        var flavorText: String {
            return pkmnLocalized(speciesFlavorText: pageViewModel.entry.species).replacingOccurrences(of: "\n", with: " ")
        }
    }
}

// Sprites
extension PokemonPageViewModel {
    class SpritesViewModel: _SubViewModel {
        let images: [UIImage]
        
        override init(pageViewModel: PokemonPageViewModel) {
            var allImages = [UIImage?]()
            let resourceId = pageViewModel.entry.resourceIdentifier
            allImages.append(UIImage(named: "main-\(resourceId)"))
            allImages.append(UIImage(named: "main-s-\(resourceId)"))
            allImages.append(UIImage(named: "main-f-\(resourceId)"))
            allImages.append(UIImage(named: "main-sf-\(resourceId)"))
            self.images = allImages.compactMap({ $0 })

            super.init(pageViewModel: pageViewModel)
        }
    }
}
