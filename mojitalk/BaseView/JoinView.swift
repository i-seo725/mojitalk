//
//  JoinView.swift
//  mojitalk
//
//  Created by 이은서 on 1/7/24.
//

import UIKit
import SnapKit

class JoinView: UIView {
    
    let title: String
    let placeholder: String
    
    lazy var titleLabel = {
        let view = UILabel()
        view.text = title
        view.font = Font.title2
        view.textColor = .brandBlack
        return view
    }()
    
    lazy var textField = {
        let view = UITextField()
        view.placeholder = "\(placeholder)"
        view.font = Font.body
        view.backgroundColor = UIColor.backgroundSecondary
        view.layer.cornerRadius = 8
        
        let padding = UIView(frame: .init(x: 0, y: 0, width: 12, height: 44))
        view.leftView = padding
        view.leftViewMode = .always
        view.rightView = padding
        view.rightViewMode = .always
        return view
    }()
    
//    let buttonInputView = UIView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 68))
//    let joinButton = TextButton(title: "가입하기", bgColor: .brandInactive, textColor: .brandWhite)
    
    init(title: String, placeholder: String) {
        self.title = title
        self.placeholder = placeholder
        super.init(frame: .zero)
        
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        addSubview(titleLabel)
        addSubview(textField)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(24)
            make.top.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
}

extension JoinView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
}
