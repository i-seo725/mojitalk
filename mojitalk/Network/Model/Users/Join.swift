//
//  Join.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import Foundation

struct Join: Codable {
    struct Request: Encodable {
        let email, password, nickname: String
        let deviceToken, phone: String?
    }
    
    struct Response: Decodable {
        let userID: Int
        let email, nickname, createdAt: String
        let profileImage, phone, vendor: String?
        let token: Token
        
        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case email, nickname, createdAt
            case profileImage, phone, vendor
            case token
        }
    }
    
    struct Token: Decodable {
        let accessToken, refreshToken: String
    }
}
