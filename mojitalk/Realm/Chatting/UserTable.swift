//
//  UserTable.swift
//  mojitalk
//
//  Created by 이은서 on 2/26/24.
//

import Foundation
import RealmSwift

class UserTable: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var email: String
    @Persisted var nickname: String
    @Persisted var profile: String
    
    convenience init(id: Int, email: String, nickname: String, profile: String) {
        self.init()
        self.id = id
        self.email = email
        self.nickname = nickname
        self.profile = profile
    }
}
