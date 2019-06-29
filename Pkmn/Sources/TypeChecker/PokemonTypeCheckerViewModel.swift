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

class PokemonTypeCheckerViewModel {
    let dataProvider: DataProvider
    
    lazy var selectionButtons: [PokemonTypeSelectionButton] = {
        return self.dataProvider.types.map(self.createSelectionButton)
    }()
    var attackSelectorButton: PokemonTypeCheckerScenarioButton!
    var defendSelectorButton: PokemonTypeCheckerScenarioButton!
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
}

// State
extension PokemonTypeCheckerViewModel {
    var currentScenario: PokemonTypeScenario {
        return attackSelectorButton.isSelected ? .attack : .defend
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
                if selectedButtons().count >= 2 {
                    selectedButtons().last?.isSelected = false
                }
            } else {
                attackSelectorButton.isSelected = false
            }
            
            updateResults()
        }
    }
}

// Logic
extension PokemonTypeCheckerViewModel {
    func updateResults() {

    }
}
