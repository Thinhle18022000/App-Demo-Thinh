//
//  ReportAPi.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 15/05/2022.
//

import Foundation

class ReportAPI{
    func getReports( completionHandle: @escaping ResultHandle<[RepostsMD], NSError>){
        BaseAPI.shard.requestMutable(url: URLServer.urlJson, method: .get) { result in
            switch result{
            case .success(let data):
                if let json = data as? [String: Any], let dataResult = json["reposts"] as? [Any]{
                    let arrayReport = ArrayReports(json: dataResult)
                    completionHandle(.success(arrayReport.arrayReports))
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
