//
//  JoinViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/7/24.
//

import UIKit
import RxSwift

class JoinViewController: BaseViewController {
    
    let email = JoinView(title: "이메일", placeholder: "이메일을 입력하세요")
    let nickname = JoinView(title: "닉네임", placeholder: "닉네임을 입력하세요")
    let contact = JoinView(title: "연락처", placeholder: "전화번호를 입력하세요")
    let password = JoinView(title: "비밀번호", placeholder: "비밀번호를 입력하세요")
    let checkPW = JoinView(title: "비밀번호 확인", placeholder: "비밀번호를 한 번 더 입력하세요")
    
    let emailCheckButton = TextButton(title: "중복 확인", bgColor: .brandInactive, textColor: .brandWhite)
    let joinButton = TextButton(title: "가입하기", bgColor: .brandInactive, textColor: .brandWhite)
    
    let validLabel = {
        let view = TextButton(title: "사용 가능한 이메일입니다.", bgColor: .brandGreen, textColor: .brandWhite)
        view.configuration?.contentInsets = .init(top: 5, leading: 16, bottom: 5, trailing: 16)
        view.isEnabled = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configNavBar()
        view.addSubview(email)
        view.addSubview(nickname)
        view.addSubview(contact)
        view.addSubview(password)
        view.addSubview(checkPW)
        view.addSubview(emailCheckButton)
        view.addSubview(joinButton)
        view.addSubview(validLabel)
    }
    
    func configNavBar() {
        guard let navBar = self.navigationController?.navigationBar else {
            return
        }
        navBar.backgroundColor = .brandWhite
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        navigationItem.title = "회원가입"
        let closeButton = UIBarButtonItem(image: .closeIcon, style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = closeButton
        navBar.tintColor = .brandBlack
    }
    
    @objc func closeButtonTapped() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    override func setConstraints() {
        
        emailCheckButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(44)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(email.snp.bottom)
        }
        
        email.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(76)
            make.trailing.equalTo(emailCheckButton.snp.leading).offset(-12)
        }
        
        nickname.snp.makeConstraints { make in
            make.top.equalTo(email.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(email.snp.height)
        }
        
        contact.snp.makeConstraints { make in
            make.top.equalTo(nickname.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(email.snp.height)
        }
        
        password.snp.makeConstraints { make in
            make.top.equalTo(contact.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(email.snp.height)
        }
        
        checkPW.snp.makeConstraints { make in
            make.top.equalTo(password.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(email.snp.height)
        }
        
        joinButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(44)
        }
        
        validLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(joinButton.snp.horizontalEdges).inset(85)
            make.bottom.equalTo(joinButton.snp.top).offset(-16)
            make.height.equalTo(36)
        }
    }
    
}
