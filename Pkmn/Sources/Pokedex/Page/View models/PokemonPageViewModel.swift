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
        case evolutionLine
    }

    private lazy var cellTypes: [PageCell] = {
        return [.basicinfo, .header, .flavorText, .evolutionLine]
    }()

    // Utils

    private lazy var isMainPokemonForSpecies: Bool = {
        return entry.species.identifier == entry.pokemon.identifier
    }()
    
    private lazy var evolutionChain: PokemonEvolutionChain = {
        let speciesId = entry.species.identifier
        return dataProvider.evolutionChainsFromSpeciesMappping[speciesId]!
    }()
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
        case .evolutionLine:
            return evolutionChain.numberOfSpeciesInChain
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
        case .evolutionLine:
            return String(describing: PokemonPageEvolutionEntryTableViewCell.self)
        }
    }
    
    func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        switch cellTypes[indexPath.section] {
        case .header:
            let cell = cell as! PokemonPageHeaderTableViewCell
            return cell.configure(with: HeaderViewModel(pageViewModel: self))
        case .basicinfo:
            let cell = cell as! PokemonPageArtworkTableViewCell
            return cell.configure(with: ArtworkViewModel(pageViewModel: self))
        case .flavorText:
            let cell = cell as! PokemonPageFlavorTextTableViewCell
            return cell.configure(with: FlavorTextViewModel(pageViewModel: self))
        case .evolutionLine:
            let cell = cell as! PokemonPageEvolutionEntryTableViewCell
            return cell.configure(with: EvolutionLineViewModel(pageViewModel: self, index: indexPath.row))
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
        let index: Int
        
        fileprivate init(pageViewModel: PokemonPageViewModel, index: Int) {
            self.index = index
            super.init(pageViewModel: pageViewModel)
        }
        
        private lazy var item: PokemonEvolutionChain = {
            return pageViewModel.evolutionChain.firstEvolutionInChain.orderedChain[index]
        }()
        
        private lazy var evolution: PokemonEvolution? = {
            if let previous = item.preEvolution {
                for possibleEvolution in previous.evolutions {
                    if possibleEvolution.next.species.identifier == item.species.identifier {
                        return possibleEvolution.requirement
                    }
                }
            }
            return nil
        }()
        
        var speciesName: String {
            return item.species.localizedName
        }
        
        var evolutionTrigger: String? {
            if let evolution = evolution {
                return "(\(evolution.evolutionTriggerIdentifier) \(evolution.minimumLevel))"
            } else {
                return nil
            }
        }
    }
}
