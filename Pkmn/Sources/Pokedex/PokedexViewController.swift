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

    @IBOutlet var contentTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = pkmnLocalizedString("TabBarTitlePokedex")
        contentTableView.reloadData()
    }
}

extension PokedexViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.entryCellIdentifier(at: indexPath),
                                                 for: indexPath) as! PokedexBaseTableViewCell
        
        cell.configure(with: viewModel.pokedexEntry(at: indexPath))

        return cell
    }
}

extension PokedexViewController: UITableViewDelegate {
    
}
