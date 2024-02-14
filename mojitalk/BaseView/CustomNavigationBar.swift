//
//  CustomNavagationBar.swift
//  mojitalk
//
//  Created by 이은서 on 2/14/24.
//

import UIKit
import SnapKit

class CustomNavigationBar: UIView {
    
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

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleSeparatorView.backgroundColor = .seperator
        addViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(leftImage)
        addSubview(titleLabel)
        addSubview(rightImage)
        addSubview(titleSeparatorView)
    }
    
    func setConstraint() {
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
            make.leading.equalTo(leftImage.snp.trailing).offset(8)
            make.trailing.equalTo(rightImage.snp.leading).inset(12)
            make.top.equalToSuperview().offset(51)
            make.height.equalTo(35)
        }
        
        titleSeparatorView.snp.makeConstraints { make in
            make.top.equalTo(leftImage.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
