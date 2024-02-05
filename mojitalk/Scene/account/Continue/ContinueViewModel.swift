//
//  ContinueViewModel.swift
//  mojitalk
//
//  Created by 이은서 on 1/18/24.
//

import Foundation
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

class ContinueViewModel {
    
    func loginWithKakaotalk(handler: @escaping () -> Void) {
        let authGroup = DispatchGroup()
        let nameGroup = DispatchGroup()
        
        authGroup.enter()
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    //do something
                    Token.access = oauthToken?.accessToken
                    Token.refresh = oauthToken?.refreshToken
                    print("leave1")
                    authGroup.leave()
                }
            }
        }
        
        nameGroup.enter()
        authGroup.notify(queue: .main) {
            UserApi.shared.me() { (user, error) in
                if let error = error {
                    print("@@@!#", error)
                }
                else {
                    print("else문 실행")
                    if let user = user {
                        let nickname = user.kakaoAccount?.profile?.nickname
//                        print(nickname)
                        Account.nickname = user.kakaoAccount?.profile?.nickname
//                        print("leave2", Account.nickname)
                        nameGroup.leave()
                    } else {
                        print("실패")
                        nameGroup.leave()
                    }
                }
            }
        }
        

        nameGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                handler()
            }
        }
    }
}
