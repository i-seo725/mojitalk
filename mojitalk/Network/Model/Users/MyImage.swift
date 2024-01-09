//
//  Image.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import Foundation

struct MyImage: Codable {
    //request?
    
    struct Response: Decodable {
        let userID: Int
        let email, nickname, createdAt: String
        let profileImage, phone, vendor: String?
        
        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case email, nickname, createdAt
            case profileImage, phone, vendor
        }

    }
}
