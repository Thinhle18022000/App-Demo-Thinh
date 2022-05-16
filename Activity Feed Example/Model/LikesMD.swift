//
//  LikesMD.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 04/05/2022.
//

import Foundation

struct LikesMD {
    var author : AuthorL?
    var content: String
    var id: Int
    var timestamp: String
    init(json:[String: Any]) {
        content = json["content"] as? String ?? ""
        id = json["id"] as? Int ?? 0
        timestamp = json["timestamp"] as? String ?? ""
        guard let author2 = json["author"] as? [String: Any] else {
            return
        }
        author = AuthorL(json: author2)
    }
}

struct AuthorL {
    var avatar: String
    var name: String
    init(json: [String: Any]) {
        avatar = json["avatar"] as? String ?? ""
        name = json["name"] as? String ?? ""
    }
}

struct ArrayLike{
    var arrayLikes:[LikesMD] = []
    init(json: [Any]) {
        for item in json{
            guard let data = item as? [String: Any] else {
                return
            }
            arrayLikes.append(LikesMD(json: data))
        }
    }
}
