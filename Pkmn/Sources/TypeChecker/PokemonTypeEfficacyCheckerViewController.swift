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

    var resultCellSize = CGSize(width: 80, height: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTypePicker()
        setupScenarios()
        updateCollectionViewCellSize()
        
        viewModel.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCollectionViewCellSize()
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
extension PokemonTypeEfficacyCheckerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func updateCollectionViewCellSize() {
        let layout = resultsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let targetCellsPerRow = 4
        let totalSize = resultsCollectionView.bounds.width
        let sectionSpacing = layout.sectionInset.left + layout.sectionInset.right
        let itemSpacing = CGFloat(targetCellsPerRow - 1) * layout.minimumInteritemSpacing
        let availableSize = totalSize - (sectionSpacing + itemSpacing)
        let width = floor(availableSize / CGFloat(targetCellsPerRow))
        
        if abs(resultCellSize.width - width) > 0.1 {
            resultCellSize.width = width
            layout.invalidateLayout()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.results[section].types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reuseIdentifier = String(describing: PokemonTypeEfficacyCollectionReusableView.self)
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokemonTypeEfficacyCollectionReusableView
        
        headerView.configure(with: viewModel.results[indexPath.section].section)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifer = String(describing: PokemonTypeEfficacyCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! PokemonTypeEfficacyCollectionViewCell

        cell.configure(with: viewModel.results[indexPath.section].types[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return resultCellSize
    }
}
