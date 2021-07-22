//
//  RealmViewController.swift
//  client-server-1347
//
//  Created by Artur Igberdin on 22.07.2021.
//

import UIKit
import RealmSwift

class PersonModel: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var id = 0
    @objc dynamic var pet = ""
    @objc dynamic var car = ""
    
    override static func primaryKey() -> String? {
         return "id"
    }

}

class RealmViewController: UIViewController {

    let personDB = PersonDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let person2 = PersonModel()
        person2.name = "Deleted"
        person2.age = 22
        person2.id = 3
        person2.pet = "Jobbby"
        person2.car = "Camar"
        
        
        DispatchQueue.main.async {
            
            self.personDB.add(person2)
            
            let _ = self.personDB.read()
            
           
            //self.personDB.delete(person2)
            
            //let _ = self.personDB.read()
            
        }

    }
    

  

}
