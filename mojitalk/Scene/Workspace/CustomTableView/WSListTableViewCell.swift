//
//  WSListTableViewCell.swift
//  mojitalk
//
//  Created by 이은서 on 2/13/24.
//

import UIKit
import SnapKit

class WSListTableViewCell: UITableViewCell {
    
    let setImageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        addSubview(setImageView)
        addSubview(titleLabel)
        titleLabel.textColor = .textPrimary
        titleLabel.font = Font.body
        
        setImageView.snp.makeConstraints { make in
            make.size.equalTo(18)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(setImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(61)
            make.centerY.equalToSuperview()
        }
    }
    
}
