//
//  PokedexViewController.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 17/08/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {
    var viewModel: PokedexViewModel!
    
    static func create(viewModel: PokedexViewModel) -> PokedexViewController? {
        if let instance = UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController() as? PokedexViewController {
            instance.viewModel = viewModel
            return instance
        }
        return nil
    }

    @IBOutlet var contentCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = pkmnLocalizedString("TabBarTitlePokedex")
        contentCollectionView.reloadData()
    }
}

extension PokedexViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.entryCellIdentifier(at: indexPath),
                                                      for: indexPath) as! PokedexBaseCollectionViewCell
        
        cell.configure(with: viewModel.pokedexEntry(at: indexPath))

        return cell
    }
}

extension PokedexViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 44)
    }
}

extension PokedexViewController: UICollectionViewDelegate {
    
}
