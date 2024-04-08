//
//  WorkspaceInitialViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/27/24.
//

import UIKit
import RxSwift

class WSInitialViewController: BaseViewController {
    
    let titleLabel = {
        let view = UILabel()
        view.text = "출시 준비 완료!"
        view.font = Font.title1
        view.textColor = .brandBlack
        view.textAlignment = .center
        return view
    }()
    
    let welcomeLabel = {
        let view = UILabel()
        if let nickname = Account.nickname {
            view.text = "\(nickname)님의 조직을 위해 새로운 새싹톡 워크스페이스를 시작할 준비가 완료되었어요!"
        } else {
            view.text = "회원님의 조직을 위해 새로운 새싹톡 워크스페이스를 시작할 준비가 완료되었어요!"
        }
        
        view.font = Font.body
        view.textColor = .brandBlack
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()
    
    let viewModel = WSInitialViewModel()
    let launchingImage = UIImageView(image: .launching)
    let createButton = TextButton(title: "워크스페이스 생성")
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(titleLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(launchingImage)
        view.addSubview(createButton)
        navigationItem.title = "시작하기"
        let closeButton = UIBarButtonItem(image: .closeIcon, style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(35)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        launchingImage.snp.makeConstraints { make in
            make.size.equalTo(368)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        createButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(44)
        }
    }
    
    @objc func closeButtonTapped() {
        viewModel.isJoinAnyWS { count in
            if count == 0 {
                self.changeRootView(WSHomeEmptyViewController())
            } else {
                self.changeRootView(WSHomeViewController())
            }
        }
    }
    
    override func bind() {
        createButton.rx.tap
            .bind(with: self) { owner, _ in
                let vc = WSAddViewController()
                let nav = UINavigationController(rootViewController: vc)
                
                owner.present(nav, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
