//
//  WSHomeViewController.swift
//  mojitalk
//
//  Created by 이은서 on 2/12/24.
//

import UIKit
import RxSwift
import RxCocoa

class WSHomeViewController: BaseViewController {
    
    let customNavBar = CustomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        view.backgroundColor = .backgroundSecondary
        view.addSubview(customNavBar)
    }
    
    override func setConstraints() {
        customNavBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(98)
        }
    }
    
    func configureTableView() {
        
    }
    
}
