//
//  BaseAPI.swift
//  NetworkingIOS
//
//  Created by ThinhLDH on 19/04/2022.
//

import Foundation
import UIKit


//enum APIError: Error {
//    case invalidURL
//    case invalidData
//}

enum APIResultHandle<T, U: NSError> {
    case success(T)
    case failure(U)
}

enum HttpMethod:String{
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case path = "PATH"
    case delete = "Delete"
}

typealias ResultHandle<T, U: NSError> = (APIResultHandle<T, U>) -> Void

class BaseAPI {
    static let shard = BaseAPI()
    
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void){
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let _ = error{
                    completion(nil)
                } else {
                    if let data = data {
                        let image = UIImage(data: data)
                        completion(image)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
        task.resume()
    }
    
    
    func requestMutable(url: String, method: HttpMethod? = nil, completionHandler: @escaping (ResultHandle<Any, NSError>)) -> Void{
        let param:[String: Any] = [:]
        guard let Url = URL(string: url) else {
            completionHandler(.failure(NSError(domain: "Error", code: 500, userInfo: nil)))
            return
        }
        var request = URLRequest(url: Url)
        if let method = method{
            request.httpMethod = method.rawValue
            switch method {
            case .get:
                print(request)
            case .post:
                do{
                    let json = try JSONSerialization.data(withJSONObject: param, options: [])
                    request.setValue("Apllication/json; charset = utf-8", forHTTPHeaderField: "Content-type")
                    request.httpBody = json
                } catch{
                    completionHandler(.failure(NSError(domain: "Error", code: 500, userInfo: nil)))
                    return
                }
            case .put:
                print(request)
            case .path:
                print(request)
            case .delete:
                print(request)
            }
        }
        if let path = Bundle.main.path(forResource: url, ofType: "json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        DispatchQueue.main.async{
                                completionHandler(.success(jsonResult))
                    }
                }
            } catch {
                completionHandler(.failure(NSError(domain: "Not found", code: 500, userInfo: nil)))
            }
        }
        // parse data
        /*
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            if error != nil{
                completionHandler(.failure(NSError(domain: "Error", code: 500, userInfo: nil)))
                return
            }
            guard let data = data else{
                completionHandler(.failure(NSError(domain: "Not Found", code: 400, userInfo: nil)))
                return
            }
            if let returnData = String(data: data, encoding: .utf8) {
                print(returnData)}
                
            do{
                
                let result = try JSONSerialization.jsonObject(with:  data, options: .fragmentsAllowed)
                DispatchQueue.main.async{
                    completionHandler(.success(result))
                }
            } catch (let err) {
                print(err)
                
                completionHandler(.failure(NSError(domain: "Not Found", code: 400, userInfo: nil)))
            }
        }
        task.resume()
 */
    }
}
