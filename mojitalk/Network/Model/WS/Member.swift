//
//  Invite.swift
//  mojitalk
//
//  Created by 이은서 on 2/7/24.
//

import Foundation

struct Invite: Codable {
    struct Request: Encodable {
        let email: String
    }
    
    struct Response: Decodable {
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
