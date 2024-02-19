//
//  Create.swift
//  mojitalk
//
//  Created by 이은서 on 2/20/24.
//

import Foundation

struct Create: Codable {
    struct Request: Encodable {
        let name: String
        let description: String?
    }
}
