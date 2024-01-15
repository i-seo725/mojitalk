//
//  Regex.swift
//  mojitalk
//
//  Created by 이은서 on 1/15/24.
//

import Foundation

enum Regex {
    static var email: String {
        "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.((com)|(co\\.kr)|(net))"
    }
    
    static var password: String {
        "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%*^&?]).{8,20}"
    }
}
