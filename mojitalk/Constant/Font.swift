//
//  Font.swift
//  mojitalk
//
//  Created by 이은서 on 1/3/24.
//

import UIKit

enum Font {
    static var title1: UIFont {
        UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    static var title2: UIFont {
        UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    static var bodyBold: UIFont {
        UIFont.systemFont(ofSize: 13, weight: .bold)
    }
    
    static var body: UIFont {
        UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    
    static var caption: UIFont {
        UIFont.systemFont(ofSize: 12, weight: .regular)
    }
}
