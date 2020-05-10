//
//  Wish.swift
//  DesireMind
//
//  Created by Vlad Rusu on 10/05/2020.
//  Copyright © 2020 Linnify. All rights reserved.
//

import Foundation

struct Wish: Codable {
    let id: Int
    let title: String
    let description: String
    let isPublic: Bool
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case isPublic = "is_public"
        case createdAt = "created_at"
        case updatedAt = "modified_at"
    }
}
