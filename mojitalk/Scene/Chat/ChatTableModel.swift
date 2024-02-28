//
//  ChatTableModel.swift
//  mojitalk
//
//  Created by 이은서 on 2/22/24.
//

import UIKit

struct ChatTableModel {
    
    let image: String
    let name: String
    let content: String
    let date: String
    
    init(image: String, name: String, content: String, date: String) {
        self.image = image
        self.name = name
        self.content = content
        self.date = date
    }
}
