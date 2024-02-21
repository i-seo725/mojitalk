//
//  Invite.swift
//  mojitalk
//
//  Created by 이은서 on 2/7/24.
//

import Foundation

struct Member: Codable {
    struct InviteRequest: Encodable {
        let email: String
    }    
}
