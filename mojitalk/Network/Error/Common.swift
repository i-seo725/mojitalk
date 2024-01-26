//
//  Common.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import Foundation

enum CommonError400: String, Error, LocalizedError {
    case E01
    case E97
    case E05
    case E02
    case E03
    case E98
    
    var errorDescription: String? {
        switch self {
        case .E01:
            "SLP 접근 권한 에러"
        case .E97:
            "알 수 없는 라우터 경로"
        case .E05:
            "만료된 엑세스 토큰"
        case .E02:
            "토큰 인증 실패"
        case .E03:
            "계정 정보 조회 실패"
        case .E98:
            "과호출 에러"
        }
    }
    
}

enum CommonError500: String, Error, LocalizedError {
    case E99
    
    var errorDescription: String? {
        switch self {
        case .E99:
            "서버 에러"
        }
    }
}
