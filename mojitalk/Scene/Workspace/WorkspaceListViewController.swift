//
//  WorkspaceListViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/31/24.
//

import UIKit

class WorkspaceHomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configureNavBar()
    }
    
    func configureNavBar() {
        let images = UIImage(named: "Vector")?.withRenderingMode(.alwaysTemplate).withTintColor(.backgroundPrimary)
//        navigationItem.titleView = UIImageView(image: image)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        imageView.image = images
        navigationItem.titleView = imageView
        
        
//        let imageView = UIImageView(image: .vector)
//        navigationItem.titleView = imageView
        
//        navigationItem.leftBarButtonItem = leftImage
//        navigationItem.rightBarButtonItem = rightImage
        
        
    }
    
    override func setConstraints() {
        
    }
}
