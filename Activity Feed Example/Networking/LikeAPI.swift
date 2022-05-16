//
//  LikeAPI.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 15/05/2022.
//

import Foundation

class LikeAPI{
    func getDataLike(completeHandle: @escaping ResultHandle<[LikesMD], NSError>){
        BaseAPI.shard.requestMutable(url: URLServer.urlJson) { (result) in
            switch result{
                case .success(let data):
                    guard let json = data as? [String: Any], let dataResult = json["likes"] as? [Any] else{
                        completeHandle(.failure(NSError(domain: "Not Found", code: 500, userInfo: nil)))
                        return
                    }
                    let arrayReport = ArrayLike(json: dataResult)
                    completeHandle(.success(arrayReport.arrayLikes))
                case .failure(let error):
                    print(error)
            }
        }
    }
}
