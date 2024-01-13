//
//  BaseViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/4/24.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
        bind()
    }
    
    func configureView() {
        view.backgroundColor = .backgroundPrimary
    }
    
    func setConstraints() { }
    
    func bind() { }
    
}

extension BaseViewController {
    
    func showToast(view: UIView) {
        UIView.animate(withDuration: 1.2, delay: 1.5, options: .curveEaseOut) {
            view.alpha = 0
        } completion: { _ in
            view.removeFromSuperview()
        }
    }
}

//extension BaseViewController {
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
//}
