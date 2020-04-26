//
//  NetworkService.swift
//  DesireMind
//
//  Created by Vlad Rusu on 26/04/2020.
//  Copyright © 2020 Linnify. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService<T: Codable> {
    
    let baseURLString: String = "http://localhost:8000/"
    let endpoint: String
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    func list(_ completion: @escaping ([T]?, Error?) -> ()) {
        self.performRequest(endpoint: endpoint, method: .get, parameters: nil, completion: completion)
    }
    
    func get(by id: Int, completion: @escaping (T?, Error?) -> ()) {
        let endpoint = "\(self.endpoint)/\(id)"
        
        self.performRequest(endpoint: endpoint, method: .get, parameters: nil, completion: completion)
    }
    
    func create(_ object: T, completion: @escaping (T?, Error?) -> ()) {
        self.performRequest(endpoint: endpoint, method: .post, parameters: object, completion: completion)
    }
    
    func update(_ id: Int, object: T, completion: @escaping (T?, Error?) -> ()) {
        let endpoint = "\(self.endpoint)/\(id)"
        
        self.performRequest(endpoint: endpoint, method: .put, parameters: object, completion: completion)
    }
    
    func delete(_ id: Int, completion: @escaping (Error?) -> ()) {
        let endpoint = "\(self.endpoint)/\(id)"
        
        self.performRequest(endpoint: endpoint, method: .delete, parameters: nil) { (_: T?, error) in
            completion(error)
        }
    }
    
    private func performRequest<U: Codable>(endpoint: String, method: HTTPMethod, parameters: U?, completion: @escaping (U?, Error?) -> ()) {
        guard let url = URL(string: "\(baseURLString)\(endpoint)") else { return }
        
        let headers = HTTPHeaders([
            "Accept": "application/json",
            "Content-Type": "application/json"
        ])
        
        AF.request(url, method: method, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers, interceptor: nil, requestModifier: nil).response { response in
            if let error = response.error {
                completion(nil, error)
            }
            
            guard let responseData = response.data else {
                let nsError = NSError(domain: "com.linnify.DesireMind", code: 100, userInfo: [
                    "message": "No response data."
                ])
                completion(nil, nsError)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                
                let objects = try jsonDecoder.decode(U.self, from: responseData)
                
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
