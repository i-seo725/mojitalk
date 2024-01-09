//
//  DeviceToken.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import Foundation

struct DeviceToken: Codable {
    struct Request: Encodable {
        let deviceToken: String
    }
}
