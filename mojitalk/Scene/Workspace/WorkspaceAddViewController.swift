//
//  WorkspaceAddViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/27/24.
//

import UIKit
import RxSwift
import RxCocoa

class WorkspaceAddViewController: BaseViewController {
    
    let profileImage = {
        let image = UIImage(named: "DummyProfile")?.withRenderingMode(.alwaysTemplate)
        let view = UIImageView(image: image)
        view.tintColor = .brandGreen
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let bubbleImage = {
        let image = UIImage(named: "Vector")?.withRenderingMode(.alwaysTemplate)
        let view = UIImageView(image: image)
        view.tintColor = .brandWhite
        return view
    }()
    
    let cameraImage = {
        let image = UIImage(named: "Camera")
        let view = UIImageView(image: image)
        view.tintColor = .brandWhite
        view.layer.borderColor = UIColor.brandWhite.cgColor
        view.layer.borderWidth = 3
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    let clearButton = {
        let view = UIButton()
        view.alpha = 0.02
        return view
    }()
    
    let name = JoinView(title: "워크스페이스 이름", placeholder: "워크스페이스 이름을 입력하세요 (필수)")
    let desc = JoinView(title: "워크스페이스 설명", placeholder: "워크스페이스를 설명하세요 (옵션)")
    let completeButton = TextButton(title: "완료")
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configureNavBar()
        view.addSubview(profileImage)
        view.addSubview(bubbleImage)
        view.addSubview(cameraImage)
        view.addSubview(name)
        view.addSubview(desc)
        view.addSubview(completeButton)
        view.addSubview(clearButton)
        name.textField.becomeFirstResponder()
    }
    
    func configureNavBar() {
        navigationItem.title = "워크스페이스 생성"
        let closeButton = UIBarButtonItem(image: .closeIcon, style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    override func setConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.centerX.equalToSuperview()
            make.size.equalTo(70)
        }
        
        bubbleImage.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top).inset(10)
            make.horizontalEdges.equalTo(profileImage.snp.horizontalEdges).inset(11)
            make.bottom.equalTo(profileImage.snp.bottom)
        }
        
        cameraImage.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalTo(profileImage.snp.top).inset(51)
            make.leading.equalTo(profileImage.snp.leading).inset(53)
        }
        
        clearButton.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top)
            make.leading.equalTo(profileImage.snp.leading)
            make.bottom.equalTo(cameraImage.snp.bottom)
            make.trailing.equalTo(cameraImage.snp.trailing)
        }
        //트러블슈팅 - UIView 안에 있는 텍스트필드 터치 안 먹음
        //-> 뷰의 높이 지정 안해서 에러 발생, debug view hierarchy로 디버깅
        name.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(76)
        }
        
        desc.snp.makeConstraints { make in
            make.top.equalTo(name.textField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(76)
        }
        
        completeButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
    }
    
    override func bind() {
        clearButton.rx.tap
            .bind(with: self) { owner, _ in
                print("클릭클릭")
            }
            .disposed(by: disposeBag)
    }
}
