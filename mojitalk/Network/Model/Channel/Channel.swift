//
//  Channel.swift
//  mojitalk
//
//  Created by 이은서 on 2/20/24.
//

import Foundation

struct Channel: Decodable {
    let wsID: Int
    let channelID: Int
    let name: String
    let desc: String?
    let ownerID: Int
    let isPrivate: Int? //0: 공개, 1: 비공개
    let createdAt: String
    let channelMembers: [UserInfo]?
    
    enum CodingKeys: String, CodingKey {
        case wsID = "workspace_id"
        case channelID = "channel_id"
        case desc = "description"
        case ownerID = "owner_id"
        case isPrivate = "private"
        case name, createdAt, channelMembers
    }
}
