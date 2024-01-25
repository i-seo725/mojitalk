//
//  UserError.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import Foundation

enum UserError: Error, LocalizedError {
    case E11
    case E12
    case E03(isEmail: Bool)
    
    var errorDescription: String {
        switch self {
        case .E11:
            "잘못된 요청입니다. 다시 시도해주세요."
        case .E12:
            "중복된 이메일입니다. 다른 이메일을 입력해주세요."
        case .E03(let isEmail):
            switch isEmail {
            case true: "이메일 또는 비밀번호가 일치하지 않습니다."
            case false: "알 수 없는 계정입니다. 다시 시도해주세요."
            }
        }
    }
}
