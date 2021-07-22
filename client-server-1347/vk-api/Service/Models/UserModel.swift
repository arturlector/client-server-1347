//
//  User1.swift
//  client-server-1347
//
//  Created by Artur Igberdin on 12.07.2021.
//

//   let friends = try? newJSONDecoder().decode(Friends.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - Friends
struct Friends: Codable {
    let response: FriendsResponse
}

// MARK: - Response
struct FriendsResponse: Codable {
    let count: Int
    let items: [UserModel]
}

// MARK: - Item
class UserModel: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var lastName: String
    @objc dynamic var photo50: String
    @objc dynamic var firstName: String
    @objc dynamic var photo100: String

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case firstName = "first_name"
        case photo100 = "photo_100"
    }
}
