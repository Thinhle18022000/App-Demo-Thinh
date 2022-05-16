//
//  NotificationsMD.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 04/05/2022.
//

import Foundation

struct NotificationsMD {
    var actors : [Actors2]? = []
    var follows: [Follows]? = []
    var id: Int
    var objects: Object2?
    var type: String
    init(json:[String: Any]) {
        id = json["id"] as? Int ?? 0
        type = json["type"] as? String ?? ""
        if let object = json["object"] as? [String: Any]{
            objects = Object2(json: object)
        }
        if let actors = json["actors"] as? [[String: Any]]{
            for actor in actors{
                let actor = Actors2(json: actor)
                self.actors?.append(actor)
            }
        }
        if let follow = json["follows"] as? [[String: Any]]{
            for follows in follow{
                let follow = Follows(json: follows)
                self.follows?.append(follow)
            }
        }
    }
}

struct Actors2{
    var user_id: Double
    var user_image: String
    var user_name: String
    init(json:[String: Any]) {
        user_id = json["user_id"] as? Double ?? 00
        user_image = json["user_image"] as? String ?? ""
        user_name = json["user_name"] as? String ?? ""
    }
}

struct Follows{
    var user_id: Double
    var user_image: String
    var user_name: String
    init(json:[String: Any]) {
        user_id = json["user_id"] as? Double ?? 00
        user_image = json["user_image"] as? String ?? ""
        user_name = json["user_name"] as? String ?? ""
    }
}

struct Object2{
    var author: String
    var content: String
    var description: String
    var image: String
    var timestamp: String
    var title: String
    var type: String
    init(json:[String: Any]) {
        author = json["author"] as? String ?? ""
        content = json["content"] as? String ?? ""
        description = json["description"] as? String ?? ""
        image = json["image"] as? String ?? ""
        timestamp = json["timestamp"] as? String ?? ""
        title = json["title"] as? String ?? ""
        type = json["type"] as? String ?? ""
    }
}

struct ArrayNotifi{
    var arrayNotifi: [NotificationsMD] = []
    init(json: [Any]){
        for item in json{
            guard let category = item as? [String: Any] else {
                continue
            }
            arrayNotifi.append(NotificationsMD(json: category))
        }
    }
}

struct ArrayActor2 {
    var arrayActor: [Actors2] = []
    init(json: [Any]){
        for item in json{
            guard let category = item as? [String: Any] else {
                continue
            }
            arrayActor.append(Actors2(json: category))
        }
    }
}

struct ArrayFollow {
    var arrayFollows: [Follows] = []
    init(json: [Any]){
        for item in json{
            guard let category = item as? [String: Any] else {
                continue
            }
            arrayFollows.append(Follows(json: category))
        }
    }
}

