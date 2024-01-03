//
//  Font.swift
//  mojitalk
//
//  Created by 이은서 on 1/3/24.
//

import UIKit

enum Font {
    var title1: UIFont {
        UIFont.boldSystemFont(ofSize: 22)
    }
    
    var title2: UIFont {
        UIFont.boldSystemFont(ofSize: 14)
    }
    
    var bodyBold: UIFont {
        UIFont.boldSystemFont(ofSize: 13)
    }
    
    var body: UIFont {
        UIFont.systemFont(ofSize: 13)
    }
    
    var caption: UIFont {
        UIFont.systemFont(ofSize: 12)
    }
}
