//
//  ObjectNotifyViewController.swift
//  client-server-1347
//
//  Created by Artur Igberdin on 26.07.2021.
//

import UIKit
import RealmSwift

class StepCounter: Object {
    @objc dynamic var steps = 0
}

class ObjectNotifyViewController: UIViewController {

    @IBOutlet weak var stepLabel: UILabel!
    
    let config = Realm.Configuration(schemaVersion: 5)
    lazy var mainRealm = try! Realm(configuration: config)
    
    let stepCounter = StepCounter()
    
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try? mainRealm.write{
            mainRealm.add(stepCounter)
        }
        
        token = stepCounter.observe { [weak self] objectChange in
            
            switch objectChange {
            
            case .change(let properties, _):
                
                print(properties)
            
            case .error(let error):
                print("error: \(error)")
           
            case .deleted:
                print("object deleted")
            }
            
            guard let self = self else { return }
            self.stepLabel.text = "Steps: \(self.stepCounter.steps)"
            
        }

        
    }
    

    @IBAction func stepUpAction(_ sender: Any) {
        
        try? mainRealm.write{
            stepCounter.steps = stepCounter.steps + 1
        }
    }
    
}
