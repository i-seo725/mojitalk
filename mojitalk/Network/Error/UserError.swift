//
//  UserError.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import Foundation

enum UserError: String, Error, LocalizedError {
    case E11
    case E12
    case E03
    
    var errorDescription: String {
        switch self {
        case .E11:
            "잘못된 요청입니다. 다시 시도해주세요."
        case .E12:
            "중복된 이메일입니다. 다른 이메일을 입력해주세요."
        case .E03:
            "계정 정보를 다시 확인해주세요."
        }
    }
}
