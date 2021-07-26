//
//  CollectionsNotifyViewController.swift
//  client-server-1347
//
//  Created by Artur Igberdin on 26.07.2021.
//

import UIKit
import RealmSwift

class Pet: Object {
    @objc dynamic var name = ""
    @objc dynamic var gender = 1
    @objc dynamic var age = 0
}

class CollectionsNotifyViewController: UIViewController {

    let config = Realm.Configuration(schemaVersion: 4)
    lazy var mainRealm = try! Realm(configuration: config)
    
    var token: NotificationToken?
    
    var pets: Results<Pet>? {
        didSet {
            
            token = pets?.observe({ changes in
                
                switch changes {
                case .initial(let results):
                    print("initial", results)
                    
                    //self?.tableView.reloadData()
                    
                case .update(let results, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                    print("update", results)
                    
                    /*
                    self?.tableView.beginUpdates()
                    self?.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    self?.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    self?.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    self?.tableView.endUpdates()
                    */
                    
                case .error(let error):
                    print("Error", error.localizedDescription)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pets = mainRealm.objects(Pet.self).filter("age > 3").sorted(byKeyPath: "name")
        
        
        let pet1 = Pet()
        pet1.name = "Fiji"
        pet1.age = 3
        
        let pet2 = Pet()
        pet2.name = "Lucky"
        pet2.age = 4
        
        let pet3 = Pet()
        pet3.name = "Richi"
        pet3.age = 2
        
        try? mainRealm.write({
            mainRealm.add([pet1, pet2, pet3])
        })
        
        print(mainRealm.configuration.fileURL as Any)
        
    }
    

 
}
