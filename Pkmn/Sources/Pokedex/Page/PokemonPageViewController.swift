//
//  PokemonPageViewController.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 21/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonPageViewController: UIViewController {
    var viewModel: PokemonPageViewModel!
    
    @IBOutlet var contentTableView: UITableView!
    
    static func create(viewModel: PokemonPageViewModel) -> PokemonPageViewController? {
        if let instance = UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController() as? PokemonPageViewController {
            instance.viewModel = viewModel
            return instance
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTableView.tableFooterView = UIView()
        contentTableView.reloadData()
    }
}

extension PokemonPageViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier(for: indexPath),
                                                 for: indexPath)
        
        viewModel.configure(cell: cell, at: indexPath)
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
