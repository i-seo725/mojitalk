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
