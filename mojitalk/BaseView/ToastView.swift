//
//  ToastView.swift
//  mojitalk
//
//  Created by 이은서 on 1/14/24.
//

import UIKit

class ToastView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brandGreen
        textColor = .brandWhite
        isHidden = true
        font = Font.body
        clipsToBounds = true
        layer.cornerRadius = 8
        numberOfLines = 2
        textAlignment = .center
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: .init(top: 5, left: 16, bottom: 5, right: 16)))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += 10
        contentSize.width += 32
        
        return contentSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
