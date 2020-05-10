//
//  NetworkProtocol.swift
//  DesireMind
//
//  Created by Vlad Rusu on 10/05/2020.
//  Copyright © 2020 Linnify. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkResponse<DataType> {
    case success(DataType)
    case error(Error)
}

protocol NetworkProtocol {
    associatedtype DataModel: Codable
    associatedtype IdType: Codable & CustomStringConvertible
    
    var endpoint: String { get }
    
    func list(completion: @escaping (NetworkResponse<[DataModel]>) -> Void)
    
    func get(by id: IdType, completion: @escaping (NetworkResponse<DataModel>) -> Void)
    
    func create(_ object: DataModel, completion: @escaping (NetworkResponse<DataModel>) -> Void)
    
    func update(objectWithId id: IdType, object: DataModel, completion: @escaping (NetworkResponse<DataModel>) -> Void)
    
    func delete(objectWithId id: IdType, completion: @escaping (NetworkResponse<Bool>) -> Void)
}

extension NetworkProtocol {
    
    func list(completion: @escaping (NetworkResponse<[DataModel]>) -> Void) {
        performRequest(endpoint: self.endpoint, method: .get, parameters: nil, completion: completion)
    }
    
    func get(by id: IdType, completion: @escaping (NetworkResponse<DataModel>) -> Void) {
        let endpoint = "\(self.endpoint)/\(id)"
        performRequest(endpoint: endpoint, method: .get, parameters: nil, completion: completion)
    }
    
    func create(_ object: DataModel, completion: @escaping (NetworkResponse<DataModel>) -> Void) {
        performRequest(endpoint: self.endpoint, method: .post, parameters: object, completion: completion)
    }
    
    func update(objectWithId id: IdType, object: DataModel, completion: @escaping (NetworkResponse<DataModel>) -> Void) {
        let endpoint = "\(self.endpoint)/\(id)"
        performRequest(endpoint: endpoint, method: .put, parameters: object, completion: completion)
    }
    
    func delete(objectWithId id: IdType, completion: @escaping (NetworkResponse<Bool>) -> Void) {
        guard let url = URL(string: "http://localhost:8000/\(self.endpoint)") else { return }
        
        let headers = HTTPHeaders([
            "Accept": "application/json",
            "Content-Type": "application/json"
        ])
        
        AF.request(url, method: .delete, parameters: [DataModel](), encoder: JSONParameterEncoder.default, headers: headers, interceptor: nil, requestModifier: nil).response { response in
            
            if let error = response.error {
                completion(.error(error))
            }
            
            completion(.success(true))
        }
    }
    
    func performRequest<U: Codable>(endpoint: String, method: HTTPMethod, parameters: U?, completion: @escaping (NetworkResponse<U>) -> ()) {
        guard let url = URL(string: "http://localhost:8000/\(endpoint)") else { return }
        
        let headers = HTTPHeaders([
            "Accept": "application/json",
            "Content-Type": "application/json",
        ])
        
        AF.request(url, method: method, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers, interceptor: nil, requestModifier: nil).response { response in
            if let error = response.error {
                completion(.error(error))
            }
            
            guard let responseData = response.data else {
                let nsError = NSError(domain: "com.linnify.DesireMind", code: 100, userInfo: [
                    "message": "No response data."
                ])
                completion(.error(nsError))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let objects = try jsonDecoder.decode(U.self, from: responseData)
                
                completion(.success(objects))
            } catch {
                completion(.error(error))
            }
        }
    }
}
