//
//  Email.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import Foundation

struct Email: Codable {
    struct Request: Encodable {
        let email: String
    }
}
