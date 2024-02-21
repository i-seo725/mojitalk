//
//  UnreadChat.swift
//  mojitalk
//
//  Created by 이은서 on 2/21/24.
//

import Foundation

struct UnreadChat: Decodable {
    let id: Int
    let name: String
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case name, count
        case id = "channel_id"
    }
}
