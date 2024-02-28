//
//  Router.swift
//  mojitalk
//
//  Created by 이은서 on 1/16/24.
//

import Foundation
import Moya

enum UserRouter {
    case join(data: Join.Request)
    case email(data: Email.Request)
    case login(data: Login.Request)
    case kakao(data: KakaoLogin.Request)
    case apple(data: AppleLogin.Request)
    case logout
    case deviceToken(data: DeviceToken.Request)
    case myView
    case myEdit(data: MyEdit.Request)
    case image
    case users(id: Int)
}

extension UserRouter: TargetType {
    var v1URL: String {
        return "/v1/users/"
    }
    
    var v2URL: String {
        return "/v2/users/"
    }
    
    var baseURL: URL {
        if let url = URL(string: Secret.BaseURL) {
            return url
        } else {
            print("유효하지 않은 url")
            return URL(string: "https://www.apple.com/kr/")!
        }
    }
        
    var path: String {
        switch self {
        case .join:
            "/v1/users/join"
        case .email:
            "/v1/users/validation/email"
        case .login:
            "/v2/users/login"
        case .kakao:
            "/v1/users/login/kakao"
        case .apple:
            "/v1/users/login/apple"
        case .logout:
            "/v1/users/logout"
        case .deviceToken:
            "/v1/users/deviceToken"
        case .myView, .myEdit:
            "/v1/users/my"
        case .image:
            "/v1/users/my/image"
        case .users(let id):
            "/v1/users/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .join, .email, .login, .kakao, .apple, .deviceToken:
            return .post
        case .logout, .users, .myView:
            return .get
        case .image, .myEdit:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .join(let data):
            return .requestJSONEncodable(data)
        case .email(let data):
            return .requestJSONEncodable(data)
        case .login(let data):
            return .requestJSONEncodable(data)
        case .kakao(let data):
            return .requestJSONEncodable(data)
        case .apple(let data):
            return .requestJSONEncodable(data)
        case .logout:
            return .requestPlain
        case .deviceToken(let data):
            return .requestJSONEncodable(data)
        case .myView:
            return .requestPlain
        case .myEdit(let data):
            return .requestJSONEncodable(data)
        case .image:
            return .uploadMultipart([])
        case .users(_):
            return .requestPlain
        }
    }
    
    
    var headers: [String : String]? {
        switch self {
        case .deviceToken:
            if let token = Token.access {
                return ["SesacKey": Secret.APIKey, "Authorization": token]
            } else {
                return ["SesacKey": Secret.APIKey]
            }
        default:
            return ["SesacKey": Secret.APIKey]
        }
    }
    
    var validationType: ValidationType {
        .successCodes
    }
    
    
}
