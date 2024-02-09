//
//  RefreshRouter.swift
//  mojitalk
//
//  Created by 이은서 on 2/21/24.
//

import Foundation
import Moya

enum RefreshRouter: TargetType {
    case refresh
    
    var baseURL: URL {
        if let url = URL(string: Secret.BaseURL + "/v1/auth") {
            return url
        } else {
            print("유효하지 않은 url")
            return URL(string: "https://www.apple.com/kr/")!
        }
    }
    
    var path: String {
        "/refresh"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        guard let access = Token.access, let refresh = Token.refresh else {
            return ["SesacKey": Secret.APIKey]
        }
        return ["SesacKey": Secret.APIKey, "Authorization": access, "RefreshToken": refresh]
    }
}
