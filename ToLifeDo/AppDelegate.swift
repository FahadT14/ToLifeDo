//
//  AppDelegate.swift
//  ToLifeDo
//
//  Created by Fahad Tariq on 20/08/2018.
//  Copyright © 2018 Fahad Tariq. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
       // print(Realm.Configuration.defaultConfiguration.fileURL)
       
    
        
        do{
            _ = try Realm()
        }
        catch{
            print("Error While Configuring ,\(error)")
            }
        return true
    }
 

}

