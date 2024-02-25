//
//  ChatTable.swift
//  mojitalk
//
//  Created by 이은서 on 2/26/24.
//

import Foundation
import RealmSwift

class ChatTable: Object {
    
    @Persisted(primaryKey: true) var chatID: Int
    @Persisted var channelID: Int
    @Persisted var channelName: String
    @Persisted var content: String
    @Persisted var date: Date
    @Persisted var user: UserTable?
    
    convenience init(chatID: Int, channelID: Int, channelName: String, content: String, date: Date, user: UserTable) {
        self.init()
        self.chatID = chatID
        self.channelID = channelID
        self.channelName = channelName
        self.content = content
        self.date = date
        self.user = user
    }
    
}
