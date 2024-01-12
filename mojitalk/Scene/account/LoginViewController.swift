//
//  LoginViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import UIKit
import RxSwift

class LoginViewController: BaseViewController {
    
    let email = JoinView(title: "이메일", placeholder: "이메일을 입력하세요")
    let password = JoinView(title: "비밀번호", placeholder: "비밀번호를 입력하세요")
    
    let buttonView = {
        let view = UIView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 68))
        view.backgroundColor = .backgroundPrimary
        return view
    }()
    let loginButton = TextButton(title: "로그인", bgColor: .brandInactive, textColor: .brandWhite)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(buttonView)
        buttonView.addSubview(loginButton)
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
        
        buttonView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
        
        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(buttonView.safeAreaLayoutGuide).inset(24)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
    }
    
    override func bind() {
        let validEmail = email.textField.rx.text.orEmpty
            .map { $0.contains("[A-Z0-9a-z]+@[A-Za-z0-9.-]+\\.com") }
    }
}
