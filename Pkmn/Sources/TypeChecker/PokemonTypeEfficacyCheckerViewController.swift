//
//  PokemonTypeEfficacyCheckerViewController.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 26/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonTypeEfficacyCheckerViewController: UIViewController {
    var viewModel: PokemonTypeCheckerViewModel!
    
    static func create(viewModel: PokemonTypeCheckerViewModel) -> PokemonTypeEfficacyCheckerViewController? {
        if let instance = UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController() as? PokemonTypeEfficacyCheckerViewController {
            instance.viewModel = viewModel
            return instance
        }
        return nil
    }
    
    @IBOutlet var typePickerCellContainerViews: [UIView]!
    @IBOutlet var attackSelectorButton: PokemonTypeCheckerScenarioButton!
    @IBOutlet var defendSelectorButton: PokemonTypeCheckerScenarioButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTypePicker()
        setupScenarios()
    }
}

// Type picker
private extension PokemonTypeEfficacyCheckerViewController {
    func setupTypePicker() {
        typePickerCellContainerViews.enumerated().forEach { index, view in
            if let button = viewModel.selectionButtonForType(at: index) {
                view.addSubview(button, pinnedToEdges: .zero)
            }
        }
    }
}

// Scenario
extension PokemonTypeEfficacyCheckerViewController {
    func setupScenarios() {
            viewModel.provideScenarioButtons(attack: attackSelectorButton,
                                             defend: defendSelectorButton)
    }
}
