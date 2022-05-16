//
//  ReportsMD.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 04/05/2022.
//

import Foundation

struct RepostsMD{
    var author: AuthorRP?
    var content: String
    var id: Int
    var timestamp: String
    init(json:[String: Any]) {
        content = json["content"] as? String ?? ""
        id = json["id"] as? Int ?? 0
        timestamp = json["timestamp"] as? String ?? ""
        guard let authors = json["author"] as? [String: Any] else {
            return
        }
        author = AuthorRP(json: authors)
    }
}

struct AuthorRP{
    var avatar: String
    var name: String
    init(json:[String: Any]) {
        avatar = json["avatar"] as? String ?? ""
        name = json["name"] as? String ?? ""
    }
}

struct ArrayReports{
    var arrayReports:[RepostsMD] = []
    init(json: [Any]){
        for item in json{
            guard let data = item as? [String: Any] else {
                return
            }
            arrayReports.append(RepostsMD(json: data))
        }
    }
}

