//
//  LoginViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/9/24.
//

import UIKit
import RxSwift

class LoginViewController: BaseViewController {
    
    let viewModel = LoginViewModel()
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
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        navigationItem.title = "로그인"
        let closeButton = UIBarButtonItem(image: .closeIcon, style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc func loginButtonTapped() {
        guard let emailValue = email.textField.text, let pwValue = password.textField.text else { return }
        let emailValidate = viewModel.emailValidate(email: emailValue)
        let pwValidate = viewModel.pwValidate(pw: pwValue)
        
        if emailValidate && pwValidate {
            //네트워크 로그인 요청
            viewModel.loginAPI(email: emailValue, pw: pwValue) { result in
                switch result {
                case .success(_):
                    self.changeRootView(WorkspaceInitialViewController())
                case .failure(let failure):
                    if let error = failure as? CommonError400 {
                        if error.rawValue == "E03" {
                            self.showToast(view: self.toastLabel, title: self.viewModel.toast.failed.rawValue)
                        } else {
                            self.showToast(view: self.toastLabel, title: self.viewModel.toast.etc.rawValue)
                        }
                    } else {
                        self.showToast(view: self.toastLabel, title: self.viewModel.toast.etc.rawValue)
                    }
                    
                }
            }
            email.titleLabel.textColor = .brandBlack
            password.titleLabel.textColor = .brandBlack
        } else if emailValidate == false && pwValidate == false {
            showEmailToast()
            password.titleLabel.textColor = .brandError
        } else if emailValidate == true && pwValidate == false {
            email.titleLabel.textColor = .brandBlack
            password.textField.becomeFirstResponder()
            showPWToast()
        } else if emailValidate == false && pwValidate == true {
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
    

    
    func showEmailToast() {
        email.titleLabel.textColor = .brandError
        email.textField.becomeFirstResponder()
        showToast(view: toastLabel, title: viewModel.toast.email.rawValue)
    }
    
    func showPWToast() {
        password.titleLabel.textColor = .brandError
        showToast(view: toastLabel, title: viewModel.toast.pw.rawValue)
    }
}
