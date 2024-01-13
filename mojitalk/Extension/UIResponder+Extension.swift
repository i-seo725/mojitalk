//
//  UIResponder+Extension.swift
//  mojitalk
//
//  Created by 이은서 on 1/11/24.
//

import UIKit

extension UIResponder {
    // 현재 응답받는 UI를 알아내기 위해 사용 (textfield, textview 등)
    
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    static var currentResponder: UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func _trap() {
        Static.responder = self
    }
    
}
