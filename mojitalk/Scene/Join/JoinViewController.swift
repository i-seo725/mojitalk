//
//  JoinViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/7/24.
//

import UIKit
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift

class JoinViewController: BaseViewController {
    
//    let scrollView = UIScrollView()
//    let contentView = {
//        let view = UIStackView(frame: .init(x: 0, y: 0, width: 0, height: UIScreen().bounds.height))
//        return view
//    }()
    let email = JoinView(title: "이메일", placeholder: "이메일을 입력하세요")
    let nickname = JoinView(title: "닉네임", placeholder: "닉네임을 입력하세요")
    let contact = JoinView(title: "연락처", placeholder: "전화번호를 입력하세요")
    let password = JoinView(title: "비밀번호", placeholder: "비밀번호를 입력하세요")
    let checkPW = JoinView(title: "비밀번호 확인", placeholder: "비밀번호를 한 번 더 입력하세요")
    let emailCheckButton = TextButton(title: "중복 확인", bgColor: .brandInactive, textColor: .brandWhite)
    let buttonView = {
        let view = UIView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 68))
        view.backgroundColor = .backgroundPrimary
        return view
    }()
    let joinButton = TextButton(title: "가입하기", bgColor: .brandInactive, textColor: .brandWhite)
    let validLabel = {
        let view = TextButton(title: "사용 가능한 이메일입니다.", bgColor: .brandGreen, textColor: .brandWhite)
        view.configuration?.contentInsets = .init(top: 5, leading: 16, bottom: 5, trailing: 16)
        view.isEnabled = false
        view.isHidden = true
        return view
    }()
    
    let isEmptyEmail = BehaviorSubject<Bool>(value: true)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboardObserver()
    }
    
    override func configureView() {
        super.configureView()
        configNavBar()
        emailCheckButton.addTarget(self, action: #selector(checkTapped), for: .touchUpInside)
        view.addSubview(email)
        view.addSubview(nickname)
        view.addSubview(contact)
        view.addSubview(password)
        view.addSubview(checkPW)
        view.addSubview(emailCheckButton)
        view.addSubview(validLabel)
        view.addSubview(buttonView)
        buttonView.addSubview(joinButton)
        password.textField.isSecureTextEntry = true
        checkPW.textField.isSecureTextEntry = true
        joinButton.isEnabled = false
        
        let tags = [email, nickname, contact, password, checkPW]
        
        for (index, item) in tags.enumerated() {
            item.textField.tag = index
        }
        
    }
    
    @objc func checkTapped() {
        print("@")
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
        
        validLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(joinButton.snp.horizontalEdges).inset(85)
            make.bottom.equalTo(joinButton.snp.top).offset(-16)
            make.height.equalTo(36)
        }
        
        buttonView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(68)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
        
        joinButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(44)
            
        }
    }
    
    override func bind() {
        email.textField.rx.text.orEmpty
            .map { $0.isEmpty }
            .bind(to: isEmptyEmail)
            .disposed(by: disposeBag)
        
        isEmptyEmail
            .bind(with: self) { owner, value in
                owner.emailCheckButton.isEnabled = !value
                owner.emailCheckButton.backgroundColor = value ? .brandInactive : .brandGreen
            }
            .disposed(by: disposeBag)
        
        let isEnableJoin = Observable.combineLatest(email.textField.rx.text.orEmpty, nickname.textField.rx.text.orEmpty, password.textField.rx.text.orEmpty, checkPW.textField.rx.text.orEmpty) {
            return !$0.isEmpty && !$1.isEmpty && !$2.isEmpty && !$3.isEmpty
        }
            
        isEnableJoin
            .bind(with: self) { owner, value in
                owner.joinButton.isEnabled = value
                owner.joinButton.backgroundColor = value ? .brandGreen : .brandInactive
            }
            .disposed(by: disposeBag)
        
        
        
        emailCheckButton.rx.tap
            .bind(with: self, onNext: { owner, _ in
                owner.validLabel.isHidden = false
                owner.showToast(view: owner.validLabel)
            })
            .disposed(by: disposeBag)
        
        let validEmail = email.textField.rx.text.orEmpty
            .map { $0.contains("[A-Z0-9a-z]+@[A-Za-z0-9.-]+\\.com") }
        
        let validNickname = nickname.textField.rx.text.orEmpty
            .map { $0.count >= 1 && $0.count <= 30 }
        
        let isValidJoin = Observable.zip(validEmail, validNickname) {
            $0 && $1
        }
        
        joinButton.rx.tap
            .bind { _ in
                print("taptap")
            }
            .disposed(by: disposeBag)
    }
    
    func configureKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
                
        buttonView.snp.updateConstraints { make in
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
            self.view.layoutIfNeeded()
        }
        
        buttonView.layer.borderColor = UIColor.seperator.cgColor
        buttonView.layer.borderWidth = 1
     
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        buttonView.layer.borderColor = nil
        buttonView.layer.borderWidth = 0
    }
    
    func joinVCKeyboardSetting() {
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 78
        IQKeyboardManager.shared.toolbarConfiguration.placeholderConfiguration.showPlaceholder = false
        IQKeyboardManager.shared.toolbarConfiguration.manageBehavior = .byPosition
        IQKeyboardManager.shared.toolbarConfiguration.placeholderConfiguration.showPlaceholder = false
    }
}
