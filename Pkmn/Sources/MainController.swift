//
//  MainController.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 08/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit
import SQLite

class MainController: NSObject {
    
    let databaseFilename = "pokedex"
    lazy var dbHandler: Connection = {
        let path = Bundle.main.path(forResource: databaseFilename, ofType: "sqlite")!
        return try! Connection(path, readonly: true)
    }()
    lazy var database: Database = Database(handler: dbHandler)
    lazy var dataProvider: DataProvider = DataProvider(db: database)
    lazy var localizationData: LocalizationData = LocalizationData(handler: dbHandler)
    lazy var localizationProvider: PokemonLocalization = PokemonLocalization(db: localizationData)
    
    func setupApplicationRootController() -> UIViewController {
        localizationGlobalProvider = localizationProvider
        
        let typeEfficacyVC = pokemonTypeEfficacyController()
        let pokedexVC = pokedexController()
        
        return rootTabBar(with: [pokedexVC, typeEfficacyVC])
    }
}

// View controllers
private extension MainController {
    func pokemonTypeEfficacyController() -> UIViewController {
        let viewModel = PokemonTypeCheckerViewModel(dataProvider: dataProvider)
        let rootController = PokemonTypeEfficacyCheckerViewController.create(viewModel: viewModel)!
        let navigationController = UINavigationController(rootViewController: rootController)
        navigationController.tabBarItem = tabBarItemForPokemonTypeEfficacy()
        
        return navigationController
    }
    
    func pokedexController() -> UIViewController {
        let viewModel = PokedexViewModel(dataProvider: dataProvider)
        let rootController = PokedexViewController.create(viewModel: viewModel)!
        let navigationController = UINavigationController(rootViewController: rootController)
        navigationController.tabBarItem = tabBarItemForPokedex()
        
        return navigationController
    }
}

// Tabbar
private extension MainController {
    func rootTabBar(with controllers: [UIViewController]) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(controllers, animated: false)
        
        return tabBarController
    }
    
    func tabBarItemForPokedex() -> UITabBarItem {
        return UITabBarItem(title: pkmnLocalizedString("TabBarTitlePokedex"),
                            image: UIImage(named: "Pokedex"),
                            tag: 0)
    }
    
    func tabBarItemForPokemonTypeEfficacy() -> UITabBarItem {
        return UITabBarItem(title: pkmnLocalizedString("TabBarTitleTypes"),
                            image: UIImage(named: "Types"),
                            tag: 0)
    }
}
