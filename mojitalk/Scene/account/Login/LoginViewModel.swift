//
//  LoginViewModel.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import Foundation
import Moya

class LoginViewModel {
    enum Toast: String {
        case email = "이메일 형식이 올바르지 않습니다."
        case pw = "비밀번호는 최소 8자 이상,\n하나 이상의 대소문자/숫자/특수 문자를 설정해주세요."
        case failed = "이메일 또는 비밀번호가 올바르지 않습니다."
        case etc = "에러가 발생했어요. 잠시 후 다시 시도해주세요."
    }
    
    let toast = Toast.self
    
    func emailValidate(email: String) -> Bool {
        let reg = Regex.email
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", reg)
        let result = emailPredicate.evaluate(with: email)
        return result
    }
    
    func pwValidate(pw: String) -> Bool {
        let reg = Regex.password
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", reg)
        let result = emailPredicate.evaluate(with: pw)
        return result
    }
    
    func loginAPI(email: String, pw: String, handler: @escaping (Result<Decodable, Error>) -> Void) {
        let data = Login.Request(email: email, password: pw, deviceToken: nil)
        
        NetworkManager.shared.request(endpoint: .login(data: data), type: Login.Response.self) { result in
            switch result {
            case .success(let success):
                Token.access = success.token.accessToken
                Token.refresh = success.token.refreshToken
                Account.nickname = success.nickname
                DispatchQueue.main.async {
                    handler(.success(success))
                }
            case .failure(let failure):
                handler(.failure(failure))
            }
        }
    }
}
