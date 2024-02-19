//
//  ChannelNetworkManager.swift
//  mojitalk
//
//  Created by 이은서 on 2/20/24.
//

import Foundation
import Alamofire
import Moya

class ChannelNetworkManager {
    
    static let shared = ChannelNetworkManager()
    private init() { }
    
    let provider = MoyaProvider<ChannelRouter>(session: Session(interceptor: Interceptor()))
    
    func request<T: Decodable>(endpoint: ChannelRouter, type: T.Type, handler: @escaping ((Result<T, Error>) -> Void)) {
        provider.request(endpoint) { result in
            switch result {
            case .success(let response):
                do {
                    let result = try JSONDecoder().decode(type, from: response.data)
                    handler(.success(result))
                } catch {
                    print(error)
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    func request(endpoint: ChannelRouter, handler: @escaping ((Result<Response, Error>) -> Void)) {
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
