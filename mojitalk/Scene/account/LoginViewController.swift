//
//  LoginViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import UIKit
import RxSwift

class LoginViewController: BaseViewController {
    
    enum Toast: String {
        case email = "이메일 형식이 올바르지 않습니다."
        case pw = "비밀번호는 최소 8자 이상,\n하나 이상의 대소문자/숫자/특수 문자를 설정해주세요."
    }
    
    let email = JoinView(title: "이메일", placeholder: "이메일을 입력하세요")
    let password = JoinView(title: "비밀번호", placeholder: "비밀번호를 입력하세요")
    
    let buttonView = {
        let view = UIView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 68))
        view.backgroundColor = .backgroundPrimary
        return view
    }()
    let loginButton = TextButton(title: "로그인", bgColor: .brandInactive, textColor: .brandWhite)
    
    let toastLabel = ToastView()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(buttonView)
        buttonView.addSubview(loginButton)
        view.addSubview(toastLabel)
        loginButton.isEnabled = false
        password.textField.isSecureTextEntry = true
        configNavBar()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
    
    @objc func loginButtonTapped() {
        if emailValidate() && pwValidate() {
            //네트워크 로그인 요청
            email.titleLabel.textColor = .brandBlack
            password.titleLabel.textColor = .brandBlack
            print("형식 굿")
        } else if emailValidate() == false && pwValidate() == false {
            showEmailToast()
            password.titleLabel.textColor = .brandError
        } else if emailValidate() == true && pwValidate() == false {
            email.titleLabel.textColor = .brandBlack
            password.textField.becomeFirstResponder()
            showPWToast()
        } else if emailValidate() == false && pwValidate() == true {
            password.titleLabel.textColor = .brandBlack
            showEmailToast()
        }
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
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
            make.height.equalTo(68)
        }
        
        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(buttonView.safeAreaLayoutGuide).inset(24)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        
        toastLabel.snp.makeConstraints { make in
            make.bottom.equalTo(loginButton.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(36)
        }
    
        toastLabel.sizeToFit()
    }
    
    override func bind() {
        let validLogin = Observable.combineLatest(email.textField.rx.text.orEmpty, password.textField.rx.text.orEmpty) { email, pw in
            return !email.isEmpty && !pw.isEmpty
        }
        
        validLogin
            .bind(with: self) { owner, value in
                owner.loginButton.isEnabled = value
                owner.loginButton.backgroundColor = value ? UIColor.brandGreen : UIColor.brandInactive
            }
            .disposed(by: disposeBag)
    }
    
    func emailValidate() -> Bool {
        guard let email = email.textField.text else { return false }
        let reg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.((com)|(co\\.kr)|(net))"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", reg)
        let result = emailPredicate.evaluate(with: email)
        return result
    }
    
    func pwValidate() -> Bool {
        guard let pw = password.textField.text else { return false }
        let reg = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%*^&?]).{8,20}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", reg)
        let result = emailPredicate.evaluate(with: pw)
        return result
    }
    
    func showEmailToast() {
        email.titleLabel.textColor = .brandError
        email.textField.becomeFirstResponder()
        showToast(view: toastLabel, title: Toast.email.rawValue)
    }
    
    func showPWToast() {
        password.titleLabel.textColor = .brandError
        showToast(view: toastLabel, title: Toast.pw.rawValue)
    }
}
