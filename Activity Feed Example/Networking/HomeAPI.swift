//
//  HomeAPI.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 05/05/2022.
//

import Foundation

class HomeAPI{
    
    func getHome( completionHandle: @escaping ResultHandle<[ActivitesMD], NSError>){
        BaseAPI.shard.requestMutable(url: URLServer.urlJson, method: .get) { result in
            switch result{
            case .success(let data):
                if let json = data as? [String: Any], let dataResult = json["activities"] as? [Any]{
                    let arrayActives = ArrayAct(json: dataResult)
                    completionHandle(.success(arrayActives.arrayAct))
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
