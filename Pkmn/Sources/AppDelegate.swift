//
//  AppDelegate.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 24/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var database: Database = try! Database(filename: "db")
    lazy var dataProvider: DataProvider = DataProvider(db: database)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let viewModel = PokemonTypeCheckerViewModel(dataProvider: dataProvider)
        let rootController = PokemonTypeEfficacyCheckerViewController.create(viewModel: viewModel)

        self.window = makeWindow(with: rootController!)
        
        return true
    }
    
    private func makeWindow(with rootController: UIViewController) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootController
        window.makeKeyAndVisible()
        
        return window
    }
}

