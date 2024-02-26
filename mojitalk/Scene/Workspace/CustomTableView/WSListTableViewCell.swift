//
//  WSListTableViewCell.swift
//  mojitalk
//
//  Created by 이은서 on 2/13/24.
//

import UIKit
import SnapKit

class WSListTableViewCell: UITableViewCell {
    
    let image = UIImageView()
    let text = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        contentView.addSubview(image)
        contentView.addSubview(text)
        text.isEnabled = false
        text.configuration?.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 16)
        
        image.snp.makeConstraints { make in
            make.size.equalTo(18)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        text.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing)
            make.width.equalTo(314)
            make.centerY.equalToSuperview()
        }
    }
    
}
