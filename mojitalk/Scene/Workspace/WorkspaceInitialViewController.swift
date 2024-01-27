//
//  WorkspaceInitialViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/27/24.
//

import UIKit
import RxSwift
import RxCocoa

class WorkspaceInitialViewController: BaseViewController {
    
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
        view.text = ""
        view.font = Font.body
        view.textColor = .brandBlack
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()
    
    let launchingImage = UIImageView(image: .launching)
    let createButton = TextButton(title: "워크스페이스 생성")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(titleLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(launchingImage)
        view.addSubview(createButton)
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
        }
        
        createButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(44)
        }
    }
    
    override func configureNavBar() {
        super.configureNavBar()
        navigationItem.title = "시작하기"
        let closeButton = UIBarButtonItem(image: .closeIcon, style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc func closeButtonTapped() {
        
    }
    
}
