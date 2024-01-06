//
//  ContinuButton.swift
//  mojitalk
//
//  Created by 이은서 on 1/6/24.
//

import UIKit

class ContinuButton: UIButton {
    
    var image: UIImage
    
    init(frame: CGRect, image: UIImage) {
        self.image = image
        super.init(frame: frame)
        
        setImage(image, for: .normal)
        layer.cornerRadius = 8
        configuration?.contentInsets = .init(top: 12, leading: 16, bottom: 12, trailing: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
