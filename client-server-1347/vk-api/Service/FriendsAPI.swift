//
//  API.swift
//  client-server-1347
//
//  Created by Artur Igberdin on 12.07.2021.
//

import Foundation
import Alamofire
import DynamicJSON
import RealmSwift

//@objcMembers
//class User3: Object {
//    
//    dynamic var id: Int = 0
//    dynamic var lastName: String = ""
//    dynamic var photo50: String = ""
//    dynamic var firstName: String = ""
//    dynamic var photo100: String = ""
//    
//    init(json: JSON) {
//        self.id = json.id.int ?? 0 //json["id"] as! Int
//        self.firstName = json.first_name.string ?? "" //json["first_name"] as! String
//        self.lastName = json.last_name.string ?? "" //json["last_name"] as! String
//    }
//}

//Ручной парсинг - JSONSerialization
struct User2 {
    
    var id: Int = 0
    var lastName: String = ""
    var photo50: String = ""
    var firstName: String = ""
    var photo100: String = ""
    
    init(json: [String: Any]) {
        self.id = json["id"] as! Int
        self.firstName = json["first_name"] as! String
        self.lastName = json["last_name"] as! String
    }
    
}

final class FriendsAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let cliendId = Session.shared.userId
    let version = "5.21"
    
    /*
    //DynamicJSON
    func getFriends3(completion: @escaping([User3])->()) {
        
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": cliendId,
            "order": "name",
            "count": 5,
            "fields": "photo_100, photo_50",
            "access_token": Session.shared.token,
            "v": version]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in

            guard let data = response.data else { return }
            print(data.prettyJSON as Any)

            guard let items = JSON(data).response.items.array else { return }
            
            let friends = items.map { User3(json: $0)}
     
            completion(friends)
            
        }
    }*/
    
    /*
    //JSONSerialization
    func getFriends2(completion: @escaping([User2])->()) {
        
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": cliendId,
            "order": "name",
            "count": 5,
            "fields": "photo_100, photo_50",
            "access_token": Session.shared.token,
            "v": version]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in

            guard let data = response.data else { return }
            print(data.prettyJSON as Any)

        
            do {
                
                let json: Any = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                let object = json as! [String: Any]
                let response = object["response"] as! [String: Any]
                let items = response["items"] as! [Any]
                
                var users: [User2] = []
                for item in items {
                    let user =  User2(json:item as! [String : Any])
                    
                    //заполнили
                    users.append(user)
                }
                
                completion(users)
                
                
            } catch {
                print(error)
            }
        }
    }
 */
    
    
     //Парсинг = Codable + Quicktype
    func getFriends(completion: @escaping([UserModel])->()) {
        
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": cliendId,
            "order": "name",
            "count": 1000,
            "fields": "photo_100, photo_50",
            "access_token": Session.shared.token,
            "v": version]
        
        let url = baseUrl + method
        
//        //Посмотрели JSON в консоли
//        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
//
//            print(response.value as Any)
//        }
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in

            print(response.request as Any)
            print(response.response as Any)

            guard let data = response.data else { return }
            print(data.prettyJSON as Any)

        
            var friendsResponse: Friends?
            do {
                friendsResponse = try JSONDecoder().decode(Friends.self, from: data)
            } catch {
                print(error)
            }
            
            guard let friends = friendsResponse?.response.items else { return }
            completion(friends)
            
        }
    }
 
    
    
}
