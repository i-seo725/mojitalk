//
//  LoginViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import UIKit

class LoginViewController: BaseViewController {
    
    let email = JoinView(title: "이메일", placeholder: "이메일을 입력하세요")
    let password = JoinView(title: "비밀번호", placeholder: "비밀번호를 입력하세요")
    let loginButton = TextButton(title: "로그인", bgColor: .brandInactive, textColor: .brandWhite)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(loginButton)
        password.textField.isSecureTextEntry = true
        configNavBar()
    }
    
    func configNavBar() {
        guard let navBar = self.navigationController?.navigationBar else {
            return
        }
        navBar.backgroundColor = .brandWhite
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        navigationItem.title = "로그인"
        let closeButton = UIBarButtonItem(image: .closeIcon, style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = closeButton
        navBar.tintColor = .brandBlack
    }
    
    @objc func closeButtonTapped() {
        presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    override func setConstraints() {
        email.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(76)
        }
        
        password.snp.makeConstraints { make in
            make.top.equalTo(email.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(76)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(44)
        }
    }
    
}
