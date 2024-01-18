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
    
    func loginWithKakaotalk() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                    print("@@@@@@@@@@  ", oauthToken)
                }
            }
        } else {
            print("실패")
        }
    }
}
