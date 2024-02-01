//
//  WorkspaceListViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/31/24.
//

import UIKit

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
    }
}
