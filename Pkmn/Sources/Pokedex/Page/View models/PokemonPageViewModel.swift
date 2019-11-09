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
        case basicinfo
        case flavorText
    }

    private lazy var cellTypes: [PageCell] = {
        return [.basicinfo, .header, .flavorText]
    }()
}

// Utils
private extension PokemonPageViewModel {
    var isMainPokemonForSpecies: Bool {
        return entry.species.identifier == entry.pokemon.identifier
    }
}

// View controller
extension PokemonPageViewModel {
    var numberOfSections: Int {
        return cellTypes.count
    }
    
    func numberOfItems(for section: Int) -> Int {
        switch cellTypes[section] {
        case .header, .basicinfo, .flavorText:
            return 1
        }
    }
    
    func cellIdentifier(for indexPath: IndexPath) -> String {
        switch cellTypes[indexPath.section] {
        case .header:
            return String(describing: PokemonPageHeaderTableViewCell.self)
        case .basicinfo:
            return String(describing: PokemonPageArtworkTableViewCell.self)
        case .flavorText:
            return String(describing: PokemonPageFlavorTextTableViewCell.self)
        }
    }
    
    func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        switch cellTypes[indexPath.section] {
        case .header:
            let cell = cell as! PokemonPageHeaderTableViewCell
            EvolutionLineViewModel(pageViewModel: self).test()
            return cell.configure(with: HeaderViewModel(pageViewModel: self))
        case .basicinfo:
            let cell = cell as! PokemonPageArtworkTableViewCell
            return cell.configure(with: ArtworkViewModel(pageViewModel: self))
        case .flavorText:
            let cell = cell as! PokemonPageFlavorTextTableViewCell
            return cell.configure(with: FlavorTextViewModel(pageViewModel: self))
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
        
        var spriteImage: UIImage? {
            return pageViewModel.entryViewModel.artImage
        }
    }
}

// Info
extension PokemonPageViewModel {
    class ArtworkViewModel: _SubViewModel {
        var artworkImage: UIImage? {
            return pageViewModel.entryViewModel.artImage
        }
    }
}

// Flavor text
extension PokemonPageViewModel {
    class FlavorTextViewModel: _SubViewModel {
        var flavorText: String {
            return pkmnLocalized(speciesFlavorText: pageViewModel.entry.species).replacingOccurrences(of: "\n", with: " ")
        }
    }
}

// Evolutions
extension PokemonPageViewModel {
    class EvolutionLineViewModel: _SubViewModel {
        var evolutionChain: PokemonEvolutionChain {
            let speciesId = pageViewModel.entry.species.identifier
            return pageViewModel.dataProvider.evolutionChainsFromSpeciesMappping[speciesId]!
        }
        
        func test() {
            var firstChain = evolutionChain
            while firstChain.preEvolution != nil {
                firstChain = firstChain.preEvolution!
            }
            
            func printChain(from: PokemonEvolutionChain, level: Int = 0, evolutionInfo: PokemonEvolution? = nil) {
                let index = String(repeating: "--", count: level)
                let info = evolutionInfo.map { "\($0.evolutionTriggerIdentifier) \($0.minimumLevel)" } ?? ""
                print("\(index) \(from.species.localizedName) (\(info))")
                from.evolutions.forEach { printChain(from: $0.next, level: level + 1, evolutionInfo: $0.requirement) }
            }
            
            printChain(from: firstChain)
        }
    }
}
