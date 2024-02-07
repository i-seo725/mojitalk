//
//  Create.swift
//  mojitalk
//
//  Created by 이은서 on 2/7/24.
//

import Foundation

struct Create: Codable {
    struct Response: Decodable {
        let id: Int
        let name: String
        let desc: String?
        let thumbnail: String
        let ownerID: Int
        let createdAt: String
        
        enum CodingKeys: String, CodingKey {
            case id = "workspace_id"
            case desc = "description"
            case ownerID = "owner_id"
            case name, thumbnail, createdAt
        }
    }
}
