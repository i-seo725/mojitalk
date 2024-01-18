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
    
    func request(endpoint: UserRouter, handler: @escaping ((Response) -> Void)) {
        provider.request(endpoint) { result in
            
            print(result, "\n\n\n")
            
            switch result {
            case .success(let response):
                let result = response
                handler(result)
            case .failure(let error):
                    print(error)
            }
        }
    }
}
