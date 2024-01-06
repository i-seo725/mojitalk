//
//  ContinueViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/6/24.
//

import UIKit
import RxSwift
import RxCocoa

class ContinueViewController: BaseViewController {
    
    let appleLoginButton = {
        let button = UIButton()
        button.setImage(.appleLogin, for: .normal)
        button.layer.cornerRadius = 8
        button.configuration?.contentInsets = .init(top: 12, leading: 16, bottom: 12, trailing: 16)
        return button
    }()
    
    var isDisappear: ((Bool) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isDisappear?(true)
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(appleLoginButton)
    }
    
    override func setConstraints() {
        appleLoginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(35)
            make.top.equalToSuperview().offset(42)
        }
    }
    
}
