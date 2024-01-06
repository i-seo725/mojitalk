//
//  ContinueViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/6/24.
//

import UIKit
import RxSwift
import RxCocoa

class ContinueViewController: BaseViewController {
    
    let appleLoginButton = ContinueButton(frame: .zero, image: .appleLogin)
    let kakaoLoginButton = ContinueButton(frame: .zero, image: .kakaoLogin)
    let emailLoginButton = ContinueButton(frame: .zero, image: .activeWithIcon)
    let joinButton = {
        let fullText = "또는 새롭게 회원가입 하기"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let range = (fullText as NSString).range(of: "또는")
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.brandBlack, range: range)
        
        let view = UIButton()
        view.setAttributedTitle(attributedString, for: .normal)
        view.setTitleColor(.brandGreen, for: .normal)
        view.titleLabel?.font = Font.title2
        return view
    }()
    
    var isDisappear: ((Bool) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isDisappear?(true)
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(appleLoginButton)
        view.addSubview(kakaoLoginButton)
        view.addSubview(emailLoginButton)
        view.addSubview(joinButton)
    }
    
    override func setConstraints() {
        appleLoginButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44)
            make.width.equalTo(323)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.top.equalTo(appleLoginButton.snp.bottom).offset(16)
            make.width.height.equalTo(appleLoginButton)
            make.centerX.equalToSuperview()
        }
        
        emailLoginButton.snp.makeConstraints { make in
            make.top.equalTo(kakaoLoginButton.snp.bottom).offset(16)
            make.width.height.equalTo(appleLoginButton)
            make.centerX.equalToSuperview()
        }
        
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(emailLoginButton.snp.bottom).offset(16)
            make.width.equalTo(appleLoginButton)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
    }
    
}
