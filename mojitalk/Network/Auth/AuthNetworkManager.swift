//
//  AuthNetworkManager.swift
//  mojitalk
//
//  Created by 이은서 on 2/21/24.
//

import Foundation
import Moya
import Alamofire

class AuthNetworkManager {
    static let shared = AuthNetworkManager()
    private init() { }
    
    let provider = MoyaProvider<RefreshRouter>()
    
    func request() {
        provider.request(.refresh) { result in
            switch result {
            case .success(let response):
                print(result)
                let result = try? JSONDecoder().decode(Refresh.self, from: response.data)
                if let result {
                    print("액세스 토큰 받기")
                    Token.access = result.accessToken
                } else {
                    print("디코딩 에러 발생@@@@@@\n", response)
                }
            case .failure(let error):
                if let data = error.response?.data {
                    let error = try? JSONDecoder().decode(ErrorResponse.self, from: data)
                    print(error)
                }
            }
        }
    }
    
    
}
