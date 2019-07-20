//
//  PokemonTypeCheckerViewModel.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 26/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

enum PokemonTypeScenario {
    case attack
    case defend
}

protocol PokemonTypeCheckerViewModelDelegate: class {
    func viewModelDidUpdate()
}

class PokemonTypeCheckerViewModel {
    private let dataProvider: DataProvider
    
    weak var delegate: PokemonTypeCheckerViewModelDelegate?
    
    private lazy var selectionButtons: [PokemonTypeSelectionButton] = {
        return self.dataProvider.types.map(self.createSelectionButton)
    }()
    private var attackSelectorButton: PokemonTypeCheckerScenarioButton!
    private var defendSelectorButton: PokemonTypeCheckerScenarioButton!
    
    typealias ResultSection = (section: PokemonTypeEfficacy.Category, types: [PokemonType])
    private var results: [ResultSection] = []
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
}

// State
extension PokemonTypeCheckerViewModel {
    var currentScenario: PokemonTypeScenario {
        return attackSelectorButton.isSelected ? .attack : .defend
    }
    
    var typeName: String? {
        guard !selectedButtons().isEmpty else {
            return nil
        }
        
        var typeName = selectedButtons()[0].type.localizedName
        if let secondName = selectedButtons()[safe: 1]?.type.localizedName {
            typeName = pkmnLocalizedString(format: "TypeCheckerCombinedTypes", typeName, secondName)
        }
        return typeName
    }
    
    var title: String {
        if let types = self.typeName {
            if currentScenario == .attack {
                return pkmnLocalizedString(format: "TypeCheckerTitleAttack", types)
            } else {
                return pkmnLocalizedString(format: "TypeCheckerTitleDefence", types)
            }
        }
        return ""
    }
}

extension PokemonTypeScenario {
    var maximumTypes: Int {
        switch self {
        case .attack:
            return 1
        case .defend:
            return 2
        }
    }
}

// Types
extension PokemonTypeCheckerViewModel {
    private func createSelectionButton(type: PokemonType) -> PokemonTypeSelectionButton {
        let button = PokemonTypeSelectionButton(type: type)
        button.addTarget(self, action: #selector(self.selectionButtonPressed(button:)), for: .touchUpInside)
        return button
    }
    
    func selectionButtonForType(at index: Int) -> PokemonTypeSelectionButton? {
        return selectionButtons[safe: index]
    }
    
    @objc func selectionButtonPressed(button: PokemonTypeSelectionButton) {
        if !button.isSelected && selectedButtons().count >= currentScenario.maximumTypes {
            selectedButtons().forEach { $0.isSelected = false }
        }

        button.isSelected = !button.isSelected
        updateResults()
    }
    
    private func selectedButtons() -> [PokemonTypeSelectionButton] {
        return self.selectionButtons.filter { $0.isSelected }
    }
}

// Scenario
extension PokemonTypeCheckerViewModel {
    func provideScenarioButtons(attack: PokemonTypeCheckerScenarioButton,
                                defend: PokemonTypeCheckerScenarioButton) {
        self.attackSelectorButton = attack
        self.defendSelectorButton = defend
        
        defendSelectorButton.isSelected = true
        
        [attack, defend].forEach { button in
            button.addTarget(self, action: #selector(self.scenarioButtonPressed(button:)), for: .touchUpInside)
        }
    }
    
    @objc func scenarioButtonPressed(button: PokemonTypeCheckerScenarioButton) {
        if !button.isSelected {
            button.isSelected = true
            if (button == attackSelectorButton) {
                defendSelectorButton.isSelected = false
                if selectedButtons().count >= PokemonTypeScenario.defend.maximumTypes {
                    selectedButtons().last?.isSelected = false
                }
            } else {
                attackSelectorButton.isSelected = false
            }
            
            updateResults()
        }
    }
}

// Results
extension PokemonTypeCheckerViewModel {
    func numberOfResultSections() -> Int {
        return results.count
    }
    
    func numberOfResultTypes(for section: Int) -> Int {
        return results[section].types.count
    }
    
    func headerViewModel(for section: Int) -> PokemonTypeCheckerEfficacyCategoryViewModel {
        return PokemonTypeCheckerEfficacyCategoryViewModel(category: results[section].section)
    }
    
    func cellType(for indexPath: IndexPath) -> PokemonType {
        return results[indexPath.section].types[indexPath.item]
    }
}

// Logic
extension PokemonTypeCheckerViewModel {
    func updateResults() {
        if !selectedButtons().isEmpty {
            results = resultTemplate()
            
            let firstType = selectedButtons()[0].type!
            let secondType = selectedButtons()[safe: 1]?.type
            
            for type in dataProvider.types {
                var category: PokemonTypeEfficacy.Category?
                
                if currentScenario == .attack {
                    if let factor = dataProvider.typeEfficacyAttackMapping.mapping[firstType.identifier]?[type.identifier] {
                        category = PokemonTypeEfficacy.Category(damageFactor: factor)
                    }
                } else {
                    let factor1 = dataProvider.typeEfficacyDefenceMapping.mapping[firstType.identifier]?[type.identifier]
                    let factor2 = secondType.flatMap { dataProvider.typeEfficacyDefenceMapping.mapping[$0.identifier]?[type.identifier] }

                    if let factor1 = factor1, let factor2 = factor2 {
                        category = PokemonTypeEfficacy.Category(category1: PokemonTypeEfficacy.Category(damageFactor: factor1),
                                                                category2: PokemonTypeEfficacy.Category(damageFactor: factor2))
                    } else if let factor1 = factor1 {
                        category = PokemonTypeEfficacy.Category(damageFactor: factor1)
                    } else if let factor2 = factor2 {
                        category = PokemonTypeEfficacy.Category(damageFactor: factor2)
                    }
                }
                
                if let category = category,
                    let index = results.firstIndex(where: { $0.section == category }),
                    category != .normal {
                    results[index].types.append(type)
                }
            }

            results = results.filter { section in !section.types.isEmpty }
        } else {
            results = []
        }
        
        delegate?.viewModelDidUpdate()
    }
    
    private func resultTemplate() -> [ResultSection] {
        return [
            (section: .doubleEffective, types: []),
            (section: .effective, types: []),
            (section: .resistant, types: []),
            (section: .doubleResistant, types: []),
            (section: .immune, types: [])
        ]
    }
}
