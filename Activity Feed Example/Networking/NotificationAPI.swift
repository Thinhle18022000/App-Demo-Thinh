//
//  NotificationAPI.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 13/05/2022.
//

import Foundation

class NotificationAPI{
    func getNotification(completetionHandle: @escaping ResultHandle<[NotificationsMD], NSError>){
        BaseAPI.shard.requestMutable(url: URLServer.urlJson) { (result) in
            switch result{
                case .success(let data):
                    guard let json = data as? [String: Any], let resualtData = json["notifications"] as? [Any] else {
                        completetionHandle(.failure(NSError(domain: "Not Found", code: 500, userInfo: nil)))
                        return
                    }
                    let arrayNotification = ArrayNotifi(json: resualtData)
                    completetionHandle(.success(arrayNotification.arrayNotifi))
                case .failure(let error):
                print(error)
            }
        }
    }
    func getNotifiFollow(completionHandle: @escaping ResultHandle<[Follows], NSError>){
        BaseAPI.shard.requestMutable(url: URLServer.urlJson) { (result) in
            switch result{
                case .success(let data):
                    let json = data as?  [String: Any]
                    let notifs = json!["notifications"] as? [[String: Any]]
                    notifs?.forEach({ (noti) in
                        let follows = noti["follows"] as? [[String:Any]]
                        let arrayFollow = ArrayFollow(json: follows ?? [[]])
                        completionHandle(.success(arrayFollow.arrayFollows))
                    })
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}

