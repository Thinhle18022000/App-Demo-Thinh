//
//  coments.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 04/05/2022.
//

import Foundation

struct CommentsMD{
    var created_at: String
    var data: DaTa?
    var id: Int
    var user: User?
    init(json:[String:Any]) {
        created_at = json["created_at"] as? String ?? ""
        id = json["id"] as? Int ?? 0
        guard let data2 = json["data"] as? [String: Any] else {
            return
        }
        data = DaTa(json: data2)
        guard let user2 = json["user"] as? [String: Any] else {
            return
        }
        user = User(json: user2)
    }
}

struct DaTa{
    var test: String?
    init(json:[String: Any]) {
        test = json["test"] as? String ?? ""
    }
}

struct User {
    var id: Int
    var dataU: DataU?
    init(json:[String: Any]) {
        id = json["id"] as? Int ?? 0
        guard let dataU2 = json["data"] as? [String: Any] else {
            return
        }
        dataU = DataU(json: dataU2)
    }
}

struct DataU {
    var name: String
    var profileImage: String
    init(json: [String: Any]) {
        name = json["name"] as? String ?? ""
        profileImage = json["profileImage"] as? String ?? ""
    }
}

struct ArrayCM{
    var arrayCM: [CommentsMD] = []
    init(json: [Any]){
        for item in json{
            guard let category = item as? [String: Any] else {
                continue
            }
            arrayCM.append(CommentsMD(json: category))
        }
    }
}
