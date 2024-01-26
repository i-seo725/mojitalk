//
//  NetworkManager.swift
//  mojitalk
//
//  Created by 이은서 on 1/16/24.
//

import Foundation
import Moya
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    let provider = MoyaProvider<UserRouter>()
    
    func requestEmailValidate(endpoint: UserRouter, handler: @escaping ((Response) -> Void)) {
        provider.request(endpoint) { result in
            switch result {
            case .success(let response):
                let result = response
                handler(result)
            case .failure(let error):
                    print(error)
            }
        }
    }
    
    func request<T: Decodable>(endpoint: UserRouter, type: T.Type, handler: @escaping ((Result<T, Error>) -> Void)) {
        provider.request(endpoint) { result in
            switch result {
            case .success(let response):
                let result = try? JSONDecoder().decode(type, from: response.data)
                if let result {
                    handler(.success(result))
                } else {
                    print("디코딩 에러 발생@@@@@@\n", response)
                }
            case .failure(let error):
                if let errorCode = error.response?.statusCode, let errorData = error.response?.data, let data = try? JSONDecoder().decode(ErrorResponse.self, from: errorData) {
                    switch errorCode {
                    case 400:
                        if let error = CommonError400(rawValue: data.errorCode) {
                            handler(.failure(error))
                        } else if let error = UserError(rawValue: data.errorCode) {
                            handler(.failure(error))
                        }
                    case 500:
                        if let error = CommonError500(rawValue: data.errorCode) {
                            handler(.failure(error))
                        }
                    default:
                        print("알 수 없는 에러 발생@@@\n", error)
                        handler(.failure(error))
                    }
                }
            }
        }
    }
}
