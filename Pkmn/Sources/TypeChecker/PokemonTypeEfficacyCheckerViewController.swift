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
    @IBOutlet var resultsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTypePicker()
        setupScenarios()
        setupResultsCollectionView()
        
        viewModel.delegate = self
    }
}

// View model delegate
extension PokemonTypeEfficacyCheckerViewController: PokemonTypeCheckerViewModelDelegate {
    func viewModelDidUpdate() {
        resultsCollectionView.reloadData()
        title = viewModel.title
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

// Results
extension PokemonTypeEfficacyCheckerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func setupResultsCollectionView() {
        resultsCollectionView.register(PokemonTypeEfficacyCollectionReusableView.self,
                                       forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                       withReuseIdentifier: String(describing: PokemonTypeEfficacyCollectionReusableView.self))
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfResultSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfResultTypes(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reuseIdentifier = String(describing: PokemonTypeEfficacyCollectionReusableView.self)
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokemonTypeEfficacyCollectionReusableView
        
        headerView.configure(with: viewModel.headerViewModel(for: indexPath.section))
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifer = String(describing: PokemonTypeEfficacyCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! PokemonTypeEfficacyCollectionViewCell

        cell.configure(with: viewModel.cellType(for: indexPath))
        return cell
    }
}
