//
//  LoginViewModel.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import Foundation

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
}
