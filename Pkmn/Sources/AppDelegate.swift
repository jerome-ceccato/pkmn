//
//  AppDelegate.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 24/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit
import SQLite

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let databaseFilename = "db"
    lazy var dbHandler: Connection = {
        let path = Bundle.main.path(forResource: databaseFilename, ofType: "sqlite3")!
        return try! Connection(path, readonly: true)
    }()
    lazy var database: Database = Database(handler: dbHandler)
    lazy var dataProvider: DataProvider = DataProvider(db: database)
    lazy var localizationData: LocalizationData = LocalizationData(handler: dbHandler)
    lazy var localizationProvider: PokemonLocalization = PokemonLocalization(db: localizationData)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        localizationGlobalProvider = localizationProvider
        
        let viewModel = PokemonTypeCheckerViewModel(dataProvider: dataProvider)
        let rootController = PokemonTypeEfficacyCheckerViewController.create(viewModel: viewModel)!
        let navigationController = UINavigationController(rootViewController: rootController)
        
        self.window = makeWindow(with: navigationController)
        
        return true
    }
    
    private func makeWindow(with rootController: UIViewController) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootController
        window.makeKeyAndVisible()
        
        return window
    }
}

