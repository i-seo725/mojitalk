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
    
    func configureNavBar() {
        guard let navBar = self.navigationController?.navigationBar else {
            return
        }
        navBar.backgroundColor = .brandWhite
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        navBar.tintColor = .brandBlack
    }
    
}

extension BaseViewController {
    
    func showToast(view: UILabel, title: String) {
        view.text = title
        view.isHidden = false
        UIView.animate(withDuration: 1.2, delay: 1.5, options: .curveEaseOut) {
            view.alpha = 0
        } completion: { value in
            view.alpha = value ? 1 : 0
            view.isHidden = value
        }
    }
    
    func updateUIOnValidationFailure(_ view: JoinView) {
        view.titleLabel.textColor = .brandError
        view.textField.becomeFirstResponder()
    }
}

//extension BaseViewController {
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
//}
