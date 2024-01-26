//
//  TokenManager.swift
//  mojitalk
//
//  Created by 이은서 on 1/26/24.
//

import Foundation

@propertyWrapper
struct TokenManager {
    
    let key: String
    
    var wrappedValue: String? {
        get {
            UserDefaults.standard.string(forKey: key)
        } set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}

enum Token {
    
    enum Key: String {
        case access
        case refresh
        case oauth
        case idToken
    }
    
    @TokenManager(key: Key.access.rawValue)
    static var access
    
    @TokenManager(key: Key.refresh.rawValue)
    static var refresh
    
    @TokenManager(key: Key.oauth.rawValue)
    static var oauth
    
    @TokenManager(key: Key.idToken.rawValue)
    static var idToken
}
