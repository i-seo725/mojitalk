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
    case users(id: String)
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
            "/join"
        case .email:
            "/validation/email"
        case .login:
            "/login"
        case .kakao:
            "/login/kakao"
        case .apple:
            "/login/apple"
        case .logout:
            "/logout"
        case .deviceToken:
            "/deviceToken"
        case .myView, .myEdit:
            "/my"
        case .image:
            "/my/image"
        case .users(let id):
            "/\(id)"
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
        case .users(let id):
            return .requestPlain
        }
    }
    
    
    var headers: [String : String]? {
        return ["SesacKey": Secret.APIKey]
    }
    
    
    
    
}
