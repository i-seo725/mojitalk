//
//  Font.swift
//  mojitalk
//
//  Created by 이은서 on 1/3/24.
//

import UIKit

enum Font {
    static var title1: UIFont {
        UIFont.boldSystemFont(ofSize: 22)
    }
    
    static var title2: UIFont {
        UIFont.boldSystemFont(ofSize: 14)
    }
    
    static var bodyBold: UIFont {
        UIFont.boldSystemFont(ofSize: 13)
    }
    
    static var body: UIFont {
        UIFont.systemFont(ofSize: 13)
    }
    
    static var caption: UIFont {
        UIFont.systemFont(ofSize: 12)
    }
}
