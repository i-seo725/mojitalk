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
    
    let viewModel = JoinViewModel()
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
    let validLabel = ToastView()
    
    let isEmptyEmail = BehaviorSubject<Bool>(value: true)
    let numText = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    lazy var joinViews = [email, nickname, contact, password, checkPW]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboardObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
        view.addSubview(buttonView)
        buttonView.addSubview(joinButton)
        view.addSubview(validLabel)
        password.textField.isSecureTextEntry = true
        checkPW.textField.isSecureTextEntry = true
        joinButton.isEnabled = false
        email.textField.keyboardType = .emailAddress
        contact.textField.keyboardType = .numberPad
        joinButton.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
        
        let tags = [email, nickname, contact, password, checkPW]
        
        for (index, item) in tags.enumerated() {
            item.textField.tag = index
        }
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
    @objc func joinButtonTapped() {
        if !viewModel.isEmailOK {
            rollBackJoinView()
            showToast(view: validLabel, title: viewModel.toast.Join.notChecked.rawValue)
            updateUIOnValidationFailure(email)
        } else if !viewModel.isNicknameOK {
            rollBackJoinView()
            showToast(view: validLabel, title: viewModel.toast.Join.incorrectNickname.rawValue)
            updateUIOnValidationFailure(nickname)
        } else if !viewModel.isContactOK {
            rollBackJoinView()
            showToast(view: validLabel, title: viewModel.toast.Join.incorrectPhoneNum.rawValue)
            updateUIOnValidationFailure(contact)
        } else if !viewModel.isPasswordOK {
            rollBackJoinView()
            showToast(view: validLabel, title: viewModel.toast.Join.incorrectPW.rawValue)
            updateUIOnValidationFailure(password)
        } else if !viewModel.isCheckedPW {
            rollBackJoinView()
            showToast(view: validLabel, title: viewModel.toast.Join.diffPW.rawValue)
            updateUIOnValidationFailure(checkPW)
        } else {
            rollBackJoinView()
            if let email = email.textField.text, let nickname = nickname.textField.text, let contact = contact.textField.text, let pw = password.textField.text {
                viewModel.joinAPI(email: email, nickname: nickname, contact: contact, password: pw) { result in
                    switch result {
                    case .success(let success):
                        print(success)
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        }
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
            make.bottom.equalTo(joinButton.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(36)
        }
        validLabel.sizeToFit()
        
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
        //이메일 중복 검사, 회원가입 버튼 활성화 검사
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
        //
        
        
        //유효성 검사
        emailCheckButton.rx.tap
            .bind(with: self) { owner, _ in
                let emailValidate = owner.viewModel.emailValidate(email: owner.email.textField.text ?? "")
                if emailValidate == true {
                    owner.email.titleLabel.textColor = .brandBlack
                    owner.viewModel.isEmailOK = true
                    owner.viewModel.emailValidateAPI(owner.email.textField.text!) { code in
                        if code == 200 {
                            owner.showToast(view: owner.validLabel, title: owner.viewModel.toast.Email.validEmail.rawValue)
                        } else if code == 400 {
                            owner.showToast(view: owner.validLabel, title: UserError.E12.errorDescription)
                            owner.updateUIOnValidationFailure(owner.email)
                        }
                    }
                } else {
                    owner.updateUIOnValidationFailure(owner.email)
                    owner.showToast(view: owner.validLabel, title: owner.viewModel.toast.Email.incorrectFormat.rawValue)
                }
            }
            .disposed(by: disposeBag)
        
        nickname.textField.rx.text.orEmpty
            .bind(with: self) { owner, nickname in
                owner.viewModel.isNicknameOK = owner.viewModel.nicknameValidate(nickname)
            }
            .disposed(by: disposeBag)
        
        contact.textField.rx.text.orEmpty
            .bind(with: self) { owner, contact in
                owner.viewModel.isContactOK = owner.viewModel.contactValidate(num: contact)
            }
            .disposed(by: disposeBag)
        
        password.textField.rx.text.orEmpty
            .bind(with: self) { owner, value in
                owner.viewModel.isPasswordOK = owner.viewModel.pwValidate(value)
            }
            .disposed(by: disposeBag)
        
        checkPW.textField.rx.text.orEmpty
            .bind(with: self) { owner, value in
                owner.viewModel.isCheckedPW = owner.password.textField.text! == value
            }
            .disposed(by: disposeBag)
    }
    
    func configureKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    func rollBackJoinView() {
        for i in joinViews {
            i.titleLabel.textColor = .brandBlack
        }
    }

}
