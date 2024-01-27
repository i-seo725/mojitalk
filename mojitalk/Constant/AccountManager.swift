//
//  AccountManager.swift
//  mojitalk
//
//  Created by 이은서 on 1/27/24.
//

import Foundation

@propertyWrapper
struct AccountManager {
    
    let key: String
    
    var wrappedValue: String? {
        get {
            UserDefaults.standard.string(forKey: key)
        } set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}

enum Account {
    
    enum User: String {
        case nickname
    }
    
    @TokenManager(key: User.nickname.rawValue)
    static var nickname
}
