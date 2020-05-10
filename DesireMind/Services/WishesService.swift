//
//  WishesService.swift
//  DesireMind
//
//  Created by Vlad Rusu on 10/05/2020.
//  Copyright © 2020 Linnify. All rights reserved.
//

import Foundation

class WishesService: NetworkProtocol {
    
    typealias DataModel = Wish
    
    typealias IdType = Int
    
    var endpoint: String {
        guard let configurationPlistPath = Bundle.main.path(forResource: "APIConfiguration", ofType: "plist") else { return "wishes" }
        guard let contentsOfPlist = NSDictionary(contentsOf: URL(fileURLWithPath: configurationPlistPath)) else { return "wishes" }
        return contentsOfPlist["wishesEndpoint"] as! String
    }
}
