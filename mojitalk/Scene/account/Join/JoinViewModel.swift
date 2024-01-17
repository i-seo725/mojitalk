//
//  JoinViewModel.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import Foundation

class JoinViewModel {
    enum ToastMessage {
        enum Email: String {
            case incorrectFormat = "이메일 형식이 올바르지 않습니다."
            case validEmail = "사용 가능한 이메일입니다. "
        }
        
        enum Join: String {
            case notChecked = "이메일 중복 확인을 진행해주세요."
            case incorrectNickname = "닉네임은 1글자 이상 30글자 이내로 부탁드려요."
            case incorrectPhoneNum = "잘못된 전화번호 형식입니다."
            case incorrectPW = "비밀번호는 최소 8자 이상, 하나 이상의 대소문자/숫자/특수 문자를 설정해주세요."
            case diffPW = "작성하신 비밀번호가 일치하지 않습니다."
            case exist = "이미 가입된 회원입니다. 로그인을 진행해주세요."
            case etc = "에러가 발생했어요. 잠시 후 다시 시도해주세요."
        }
    }

    let toast = ToastMessage.self
    let emailRegex = "[A-Z0-9a-z]+@[A-Za-z0-9.-]+\\.com"
    
    func emailValidate(email: String) -> Bool {
        let reg = Regex.email
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", reg)
        let result = emailPredicate.evaluate(with: email)
        return result
    }
}
