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
        return view
    }()
    
    init(title: String, placeholder: String) {
        self.title = title
        self.placeholder = placeholder
        super.init(frame: .zero)
        
        configureView()
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
