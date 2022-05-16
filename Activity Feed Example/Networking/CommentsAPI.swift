//
//  CommentsAPI.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 12/05/2022.
//

import Foundation

class CommentsAPI{
    func getComments( completionHandle: @escaping ResultHandle<[CommentsMD], NSError>){
        BaseAPI.shard.requestMutable(url: URLServer.urlJson, method: .get) { result in
            switch result{
            case .success(let data):
                if let json = data as? [String: Any], let dataResult = json["comments"] as? [Any]{
                    let arrayComments = ArrayCM(json: dataResult)
                    completionHandle(.success(arrayComments.arrayCM))
                } else {
                    completionHandle(.failure(NSError(domain: "asd", code: 400, userInfo: nil)))
                    return
                }
            case .failure(let err):
                print(err)
            }
        }
    }
}
