//
//  CustomHeader.swift
//  mojitalk
//
//  Created by 이은서 on 2/26/24.
//

import UIKit

class CustomHeader: UIView {
    let titleLabel = {
        let view = UILabel()
        view.font = Font.title2
        return view
    }()
    
    let chevron = {
        let view = UIImageView()
        view.image = .chevronDown
        return view
    }()
    
    let separatorView = {
        let view = UIView()
//        view.backgroundColor = .separator
        view.layer.borderColor = UIColor.seperator.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        addSubview(titleLabel)
        addSubview(chevron)
        addSubview(separatorView)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        chevron.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
