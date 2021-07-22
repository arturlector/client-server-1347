//
//  PersonDB.swift
//  client-server-1347
//
//  Created by Artur Igberdin on 22.07.2021.
//


import Foundation
import RealmSwift

protocol PersonDBProtocol {
    
    func add(_ user: PersonModel)
    func read() -> [PersonModel]
    func delete(_ user: PersonModel)
}

class PersonDB: PersonDBProtocol {
    
    let config = Realm.Configuration(schemaVersion: 3)
    lazy var mainRealm = try! Realm(configuration: config)
    
    func add(_ user: PersonModel) {
        
        //DispatchQueue.main.async {
            do {
                self.mainRealm.beginWrite()
                self.mainRealm.add(user)
                try self.mainRealm.commitWrite()
                
            } catch {
                print(error.localizedDescription)
            }
        //}
        
    }
    
    func read() -> [PersonModel] {
        
            let users = mainRealm.objects(PersonModel.self)
            
            users.forEach { print($0.name, $0.car, $0.id) }
        
            print(mainRealm.configuration.fileURL)
            
            return Array(users)
        
    }
    
    func delete(_ user: PersonModel) {
        //DispatchQueue.main.async {
            do {
                self.mainRealm.beginWrite()
                self.mainRealm.delete(user)
                try self.mainRealm.commitWrite()
            } catch {
                print(error.localizedDescription)
            }
        //}
        
    }
    
    
    
}
