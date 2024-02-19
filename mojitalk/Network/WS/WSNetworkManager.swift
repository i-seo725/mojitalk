//
//  WSNetworkManager.swift
//  mojitalk
//
//  Created by 이은서 on 2/8/24.
//

import Foundation
import Moya
import Alamofire

class WSNetworkManager {
    static let shared = WSNetworkManager()
    private init() { }
    
    let provider = MoyaProvider<WSRouter>(session: Session(interceptor: Interceptor()))
    
    func request<T: Decodable>(endpoint: WSRouter, type: T.Type, handler: @escaping ((Result<T, Error>) -> Void)) {
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
                handler(.failure(error))
            }
        }
    }
    
    func request(endpoint: WSRouter, handler: @escaping ((Result<Response, Error>) -> Void)) {
        provider.request(endpoint) { result in
            switch result {
            case .success(let response):
                handler(.success(response))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
