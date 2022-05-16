//
//  Activities.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 04/05/2022.
//

import Foundation

struct ActivitesMD{
    var author: AuthorA?
    var content: String
    var id: Int
    var to: String
    var type: String
    var image: String
    var link: Bool
    var object : Object?
    var timestamp: String
    init(json:[String:Any]){
        content = json["content"] as? String ?? ""
        id = json["id"] as? Int ?? 0
        timestamp = json["timestamp"] as? String ?? ""
        to = json["to"] as? String ?? ""
        type = json["type"] as? String ?? ""
        image = json["image"] as? String ?? ""
        link = json["link"] as? Bool ?? false
        guard let auThor = json["author"] as? [String: Any] else {
            return
        }
        author = AuthorA(json: auThor)
        
        guard let object2 = json["object"] as? [String: Any] else {
            return
        }
        object = Object(json: object2)
    }
}

struct Object{
    var description: String
    var title: String
    var type: String
    init(json: [String:Any]) {
        description = json["description"] as? String ?? ""
        title = json["title"] as? String ?? ""
        type = json["type"] as? String ?? ""
    }
}

struct AuthorA{
    var handle: String
    var name: String
    var user_image: String
    init(json:[String:Any]) {
        handle = json["handle"] as? String ?? ""
        name = json["name"] as? String ?? ""
        user_image = json["user_image"] as? String ?? ""
    }
}
struct ArrayAct{
    var arrayAct: [ActivitesMD] = []
    init(json: [Any]){
        for item in json{
            guard let category = item as? [String: Any] else {
                continue
            }
            arrayAct.append(ActivitesMD(json: category))
        }
    }
}
