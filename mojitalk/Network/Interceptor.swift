////
////  Interceptor.swift
////  mojitalk
////
////  Created by 이은서 on 1/19/24.
////
//
//import Foundation
//import Alamofire
//
//class Interceptor: RequestInterceptor {
//    
//    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        
//        guard let token = Token.token else {
//            completion(.success(urlRequest))
//            print("저장된 액세스 토큰 없음")
//            return
//        }
//
//        var urlRequest = urlRequest
//        urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
//        completion(.success(urlRequest))
//    }
//    
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//        
//        guard let response = request.task?.response as? HTTPURLResponse else {
//            completion(.doNotRetry)
//            return
//        }
//        
//        guard let refresh = Token.refresh, response.statusCode == 419 else {
//            if response.statusCode == 418 {
//                DispatchQueue.main.async {
//                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
//                    let vc = LoginViewController()
//                    vc.type = .relogin
//                    sceneDelegate?.window?.rootViewController = vc
//                    sceneDelegate?.window?.makeKeyAndVisible()
//                }
//            }
//            completion(.doNotRetry)
//            return
//        }
//        
//        
//        DispatchQueue.global().async {
//            NetworkManager.shared.request(type: Refresh.Response.self, errorType: RefreshError.self, endpoint: .refresh(refresh: refresh)) { result in
//                switch result {
//                case .success(let success):
//                    Token.token = success.token
//                    completion(.retry)
//                case .failure(let failure):
//                    print(failure)
//                }
//            }
//        }
//    }
//}
//
