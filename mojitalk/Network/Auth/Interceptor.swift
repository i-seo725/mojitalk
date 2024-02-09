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
        
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetry)
            return
        }
        
        
    }
}

