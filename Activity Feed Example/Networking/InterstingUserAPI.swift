//
//  InterstingUserAPI.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 11/05/2022.
//

import Foundation

class InterestingUser{
    
    func getUser(completionHandle: @escaping ResultHandle<[Actors2], NSError>){
        BaseAPI.shard.requestMutable(url: URLServer.urlJson) { (result) in
            switch result{
                case .success(let data):
                    let json = data as?  [String: Any]
                    let notifs = json!["notifications"] as? [[String: Any]]
                    notifs?.forEach({ (noti) in
                        let actors = noti["actors"] as? [[String:Any]]
                        let arrayActor = ArrayActor2(json: actors ?? [[]])
                        completionHandle(.success(arrayActor.arrayActor))
                    })
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}
