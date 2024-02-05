//
//  WorkspaceListViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/31/24.
//

import UIKit
import RxSwift
import RxCocoa

class WorkspaceHomeViewController: BaseViewController {
    
    let titleSeparatorView = UIView()
    let leftImage = {
        let view = UIImageView(image: .vector)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .brandGray
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.font = Font.title1
        view.textAlignment = .left
        view.numberOfLines = 1
        view.textColor = .textPrimary
        view.text = "No Workspace"
        return view
    }()
    
    let rightImage = {
        let view = UIImageView(image: .noPhotoCProfile)
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor.border.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let firstLabel = {
        let view = UILabel()
        view.text = "워크스페이스를 찾을 수 없어요."
        view.font = Font.title1
        return view
    }()
    
    let secondLabel = {
        let view = UILabel()
        view.text = "관리자에게 초대를 요청하거나, 다른 이메일로 시도하거나\n새로운 워크스페이스를 생성해주세요."
        view.font = Font.body
        view.numberOfLines = 2
        return view
    }()
    
    let emptyImageView = {
        let view = UIImageView()
        view.image = .workspaceEmpty
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let createButton = TextButton(title: "워크스페이스 생성")
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configureNavBar()
        view.backgroundColor = .backgroundSecondary
        view.addSubview(leftImage)
        view.addSubview(titleLabel)
        view.addSubview(rightImage)
        view.addSubview(titleSeparatorView)
        titleSeparatorView.backgroundColor = .seperator
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(emptyImageView)
        view.addSubview(createButton)
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func setConstraints() {
        leftImage.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.top.equalToSuperview().offset(52)
            make.leading.equalToSuperview().offset(16)
        }
                
        rightImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(53)
            make.size.equalTo(32)
            make.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(leftImage)
            make.leading.equalTo(leftImage.snp.trailing).offset(8)
            make.trailing.equalTo(rightImage.snp.leading).inset(12)
        }

        titleSeparatorView.snp.makeConstraints { make in
            make.top.equalTo(leftImage.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.top.equalTo(titleSeparatorView.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(firstLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(secondLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(368)
        }
        
        createButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(44)
        }
    }
    
    override func bind() {
        createButton.rx.tap
            .bind(with: self) { owner, _ in
                let vc = UINavigationController(rootViewController: WorkspaceAddViewController())
                owner.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
