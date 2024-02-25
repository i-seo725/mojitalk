//
//  Interceptor.swift
//  mojitalk
//
//  Created by 이은서 on 1/19/24.
//

import Foundation
import Alamofire

class Interceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        guard let token = Token.access else {
            completion(.success(urlRequest))
            print("저장된 액세스 토큰 없음")
            return
        }

        var urlRequest = urlRequest
        urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard let request = request as? DataRequest, let data = request.data, let result = try? JSONDecoder().decode(ErrorResponse.self, from: data) else {
            completion(.doNotRetry)
            return
        }
        
        if result.errorCode == "E05" {
            AuthNetworkManager.shared.request()
            completion(.retry)
        } else if result.errorCode == "E06" {
            completion(.doNotRetry)
            print("재로그인 필요")
        } else {
            print(result)
            completion(.doNotRetry)
        }
        
    }
}

