//
//  Create.swift
//  mojitalk
//
//  Created by 이은서 on 2/7/24.
//

import Foundation

//생성, 전체 조회, 편집, 퇴장, 관리자 변경
struct WS: Codable {
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
