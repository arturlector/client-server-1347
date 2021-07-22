//
//  StorageViewController.swift
//  client-server-1347
//
//  Created by Artur Igberdin on 15.07.2021.
//

import UIKit
import SwiftKeychainWrapper
import RealmSwift

class User: Object {
    @objc dynamic var userId: String = ""
    @objc dynamic var name: String = ""
}

class StorageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //useUserDefaults()
        
        //useKeychainWrapper()
        
        useRealmDB()
        readUser()
    }
    
    func useRealmDB() {
        
        let user = User()
        user.name = "Fin"
        user.userId = "101"
        
        let realm = try! Realm()
        
        try? realm.write{
            realm.add(user)
        }
    }
    
    func readUser() {
        
        do {
            let realm = try Realm()
            
            let users = realm.objects(User.self)
            
            print(users.map{ $0.name })
        } catch {
            print(error)
        }
    }
    
    func useKeychainWrapper() {
        
        let vkToken = KeychainWrapper.standard.integer(forKey: "vkToken")
        let login = KeychainWrapper.standard.string(forKey: "login")
        
        print(vkToken)
        print(login)
        
        KeychainWrapper.standard.set(134123443, forKey: "vkToken")
        KeychainWrapper.standard.set("admin1234", forKey: "login")
        
        print(vkToken)
        print(login)
        
    }
    
    func useUserDefaults() {
        
        var onboarding = UserDefaults.standard.bool(forKey: "onboarding")
        var step = UserDefaults.standard.integer(forKey: "step")
        
        print(onboarding)
        print(step)
        
        UserDefaults.standard.set(true, forKey: "onboarding")
        UserDefaults.standard.set(3, forKey: "step")
        
        print(onboarding)
        print(step)
        
    }

}

