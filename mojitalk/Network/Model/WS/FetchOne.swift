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
    
    struct Channel: Decodable {
        let wsID: Int
        let channelID: Int
        let name: String
        let desc: String?
        let ownerID: Int
        let isPrivate: Bool?
        let createdAt: String
        
        enum CodingKeys: String, CodingKey {
            case wsID = "workspace_id"
            case channelID = "channel_id"
            case desc = "description"
            case ownerID = "owner_id"
            case isPrivate = "private"
            case name, createdAt
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
