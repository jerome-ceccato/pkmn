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
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self

        navigationItem.title = pkmnLocalizedString("TabBarTitlePokedex")
        setupSearchController()
        reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selectedPath = contentTableView.indexPathForSelectedRow {
            contentTableView.deselectRow(at: selectedPath, animated: true)
        }
    }
}

extension PokedexViewController: PokedexViewModelDelegate {
    func reloadData() {
        contentTableView.reloadData()
    }
}

extension PokedexViewController {
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = viewModel
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            searchController.searchBar.sizeToFit()
            contentTableView.tableHeaderView = searchController.searchBar
        }

        definesPresentationContext = true
    }
}

extension PokedexViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(for: section)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.entryCellIdentifier(at: indexPath),
                                                 for: indexPath) as! PokedexTableViewCell
        
        cell.configure(with: viewModel.pokedexEntry(at: indexPath))
        
        return cell
    }
}

extension PokedexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pageViewModel = viewModel.pageViewModel(at: indexPath)
        let pageViewController = PokemonPageViewController.create(viewModel: pageViewModel)!

        navigationController?.pushViewController(pageViewController, animated: true)
    }
}
