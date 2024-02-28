//
//  Chat.swift
//  mojitalk
//
//  Created by 이은서 on 2/21/24.
//

import Foundation

struct Chat: Decodable {
    let channelID: Int
    let channelName: String
    let chatID: Int
    let content: String?
    let createdAt: String
    let files: [String]
    let user: UserInfo
    
    enum CodingKeys: String, CodingKey {
        case channelName, content, createdAt, files, user
        case channelID = "channel_id"
        case chatID = "chat_id"
    }
}
