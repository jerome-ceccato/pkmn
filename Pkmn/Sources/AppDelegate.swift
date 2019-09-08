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
    var mainController: MainController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        mainController = MainController()
        self.window = makeWindow(with: mainController.setupApplicationRootController())
        
        return true
    }

    private func makeWindow(with rootController: UIViewController) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootController
        window.makeKeyAndVisible()
        
        return window
    }
}

