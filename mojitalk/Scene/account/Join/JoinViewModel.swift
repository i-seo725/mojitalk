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
            case incorrectPW = "비밀번호는 최소 8자 이상,\n하나 이상의 대소문자/숫자/특수 문자를 설정해주세요."
            case diffPW = "작성하신 비밀번호가 일치하지 않습니다."
            case exist = "이미 가입된 회원입니다. 로그인을 진행해주세요."
            case etc = "에러가 발생했어요. 잠시 후 다시 시도해주세요."
        }
    }

    let toast = ToastMessage.self
    let contactRegex = "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$"
    
    //회원가입 유효성 검사 통과 여부
    var isEmailOK = false
    var isNicknameOK = false
    var isContactOK = true
    var isPasswordOK = false
    var isCheckedPW = false
    
    func emailValidate(email: String) -> Bool {
        let reg = Regex.email
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", reg)
        let result = emailPredicate.evaluate(with: email)
        return result
    }
    
    func nicknameValidate(_ nickname: String) -> Bool {
        return nickname.count >= 1 && nickname.count <= 30 ? true : false
    }
    
    func contactValidate(num: String) -> Bool {
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", contactRegex)
        let result = numberPredicate.evaluate(with: num)
        return result || num.isEmpty
    }
    
    func pwValidate(_ pw: String) -> Bool {
        let pwPredicate = NSPredicate(format: "SELF MATCHES %@", Regex.password)
        let result = pwPredicate.evaluate(with: pw)
        return result
    }
    
    func joinAPI(email: String, nickname: String, contact: String?, password: String, handler: @escaping (Result<Decodable, Error>) -> Void) {
        if isEmailOK && isNicknameOK && isContactOK && isPasswordOK && isCheckedPW {
            let data = Join.Request(email: email, password: password, nickname: nickname, deviceToken: nil, phone: contact)
            
            UserNetworkManager.shared.request(endpoint: .join(data: data), type: Join.Response.self) { result in
                print(result)
                switch result {
                case .success(let success):
                    Token.access = success.token.accessToken
                    Token.refresh = success.token.refreshToken
                    Account.nickname = success.nickname
                    handler(.success(success))
                case .failure(let failure):
                    handler(.failure(failure))
                }
            }
        } else {
            print("유효성 검사 확인 필요")
        }
    }
    
    func emailValidateAPI(_ value: String, handler: @escaping (Int) -> Void) {
        let data = Email.Request(email: value)
        UserNetworkManager.shared.requestEmailValidate(endpoint: .email(data: data)) { result in
            switch result {
            case .success(let success):
                handler(200)
            case .failure(let failure):
                handler(400)
            }
        }
    }
    
    func contactFormatted(_ value: String) -> String {
        //010 등등 검증
        let firstPredicate = NSPredicate(format: "SELF MATCHES %@", "01(0|1|6|7|8|9)")
        let firstResult = firstPredicate.evaluate(with: value.prefix(3))
//        value.insert("-", at: value.index(value.startIndex, offsetBy: 3))
//        value.insert("-", at: value.index(value.endIndex, offsetBy: -4))
        
        //
        let secondPredicate = NSPredicate(format: "SELF MATCHES %@", "[0-9]{7,8}")
        let secondValueIndex = value.index(value.startIndex, offsetBy: 2)
        let secondValue = String(value[secondValueIndex...])
        
        let secondResult = secondPredicate.evaluate(with: secondValue)

        return ""
    }
    
}
