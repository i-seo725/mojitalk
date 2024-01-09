//
//  Router.swift
//  mojitalk
//
//  Created by 이은서 on 1/16/24.
//

import Foundation
import Moya

enum UserRouter {
    case join
    case email
    case login
    case kakao
    case apple
    case logout
    case deviceToken
    case myView
    case myEdit
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
        case .join:
            <#code#>
        case .email:
            <#code#>
        case .login:
            <#code#>
        case .kakao:
            <#code#>
        case .apple:
            <#code#>
        case .logout:
            <#code#>
        case .deviceToken:
            <#code#>
        case .myView:
            <#code#>
        case .myEdit:
            <#code#>
        case .image:
            <#code#>
        case .users(let id):
            <#code#>
        }
    }
    
    var headers: [String : String]? {
        <#code#>
    }
    
    
    
    
}
