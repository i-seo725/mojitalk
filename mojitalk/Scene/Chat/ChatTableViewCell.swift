//
//  chatTableViewCell.swift
//  mojitalk
//
//  Created by 이은서 on 2/22/24.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    let profileImage = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let nameLabel = {
        let view = UILabel()
        view.font = Font.caption
        view.textColor = .brandBlack
        return view
    }()
    
    let bubbleView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.brandInactive.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let contentLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = Font.body
        view.textColor = .brandBlack
        return view
    }()
    
    let dateLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 11, weight: .regular)
        view.textColor = .textSecondary
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.sizeToFit()
        contentLabel.sizeToFit()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        addSubview(profileImage)
        addSubview(nameLabel)
        addSubview(bubbleView)
        addSubview(dateLabel)
        bubbleView.addSubview(contentLabel)
        
        profileImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(6)
            make.size.equalTo(34)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top)
            make.leading.equalTo(profileImage.snp.trailing).offset(8)
        }
        
        bubbleView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(nameLabel.snp.leading)
            make.width.equalTo(244)
            make.height.equalTo(34)
//            make.width.lessThanOrEqualTo(244)
//            make.height.greaterThanOrEqualTo(34)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(bubbleView.snp.trailing).offset(8)
            make.bottom.equalTo(bubbleView.snp.bottom)
        }
    }
    
}
