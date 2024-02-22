//
//  ChatTableModel.swift
//  mojitalk
//
//  Created by 이은서 on 2/22/24.
//

import UIKit

struct ChatTableModel {
    
    let image: UIImage
    let name: String
    let content: String
    let date: String
    
    init(name: String, content: String, date: String) {
        self.image = [UIImage.noPhotoAProfile, UIImage.noPhotoBProfile, UIImage.noPhotoCProfile].randomElement()!
        self.name = name
        self.content = content
        self.date = date
    }
}
