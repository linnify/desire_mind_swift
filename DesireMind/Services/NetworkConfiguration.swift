//
//  NetworkConfiguration.swift
//  DesireMind
//
//  Created by Vlad Rusu on 10/05/2020.
//  Copyright © 2020 Linnify. All rights reserved.
//

import Foundation

class NetworkConfiguration {
    
    static let shared = NetworkConfiguration()
    
    private lazy var configuration: [String: String] = {
        guard let configurationPlistPath = Bundle.main.path(forResource: "APIConfiguration", ofType: "plist") else { return [:] }
        guard let contentsOfPlist = NSDictionary(contentsOf: URL(fileURLWithPath: configurationPlistPath)) else { return [:] }
        return contentsOfPlist as! [String: String]
    }()
    
    var baseURL: String {
        return configuration["baseURL"]!
    }
    
    var wishesEndpoint: String {
        return configuration["wishesEndpoint"]!
    }
}
