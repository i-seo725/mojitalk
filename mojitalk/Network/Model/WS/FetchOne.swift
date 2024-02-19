//
//  FetchOne.swift
//  mojitalk
//
//  Created by 이은서 on 2/7/24.
//

import Foundation

//fetchOne + Search
struct FetchOne: Codable {
    struct Response: Decodable {
        let id: Int
        let name: String
        let desc: String?
        let thumbnail: String
        let ownerID: Int
        let createdAt: String
        let channels: [Channel]?
        let wsMembers: [WSMembers]?
        
        enum CodingKeys: String, CodingKey {
            case id = "workspace_id"
            case desc = "description"
            case ownerID = "owner_id"
            case wsMembers = "workspaceMembers"
            case name, thumbnail, createdAt, channels
        }
    }
    
    struct WSMembers: Decodable {
        let userID: Int
        let email: String
        let nickname: String
        let profileImage: String?
 
        enum CodingKeys: String, CodingKey {
            case email, nickname, profileImage
            case userID = "user_id"
        }
    }
}
