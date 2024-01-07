//
//  TextButton.swift
//  mojitalk
//
//  Created by 이은서 on 1/8/24.
//

import UIKit

class TextButton: UIButton {
    
    let title: String
    let bgColor: UIColor
    let textColor: UIColor
    
    init(title: String, bgColor: UIColor, textColor: UIColor) {
        self.title = title
        self.bgColor = bgColor
        self.textColor = textColor
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        layer.cornerRadius = 8
        configuration?.contentInsets = .init(top: 11, leading: 16, bottom: 11, trailing: 16)
        backgroundColor = bgColor
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = Font.title2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
