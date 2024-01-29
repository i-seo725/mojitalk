//
//  WorkspaceAddViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/27/24.
//

import UIKit

class WorkspaceAddViewController: BaseViewController {
    
//    let profileImage =
    
    let name = JoinView(title: "워크스페이스 이름", placeholder: "워크스페이스 이름을 입력하세요 (필수)")
    let desc = JoinView(title: "워크스페이스 설명", placeholder: "워크스페이스를 설명하세요 (옵션)")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configureNavBar()
    }
    
    func configureNavBar() {
        navigationController?.title = "워크스페이스 생성"
        let closeButton = UIBarButtonItem(image: .closeIcon, style: .plain, target: self, action: #selector(closeButtonTapped))
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    override func setConstraints() {
        
    }
}
