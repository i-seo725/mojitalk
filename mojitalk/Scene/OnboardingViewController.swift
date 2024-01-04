//
//  ViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/3/24.
//

import UIKit

class OnboardingViewController: BaseViewController {

    let contentLabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.text = "모히톡을 사용하면 어디서나\n팀을 모을 수 있습니다"
        view.font = .systemFont(ofSize: 22, weight: .bold)
        view.textColor = .brandBlack
        view.textAlignment = .center
        return view
    }()
    
    let onboardingImage = {
        let view = UIImageView()
        view.image = Image.onboarding
        return view
    }()
    
    let startButton = {
        let view = UIButton()
        view.setTitle("시작하기", for: .normal)
        view.backgroundColor = .brandGreen
        view.setTitleColor(.brandWhite, for: .normal)
        view.titleLabel?.font = Font.title2
        view.layer.cornerRadius = 8
        view.configuration?.contentInsets = .init(top: 11, leading: 16, bottom: 11, trailing: 16)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(contentLabel)
        view.addSubview(onboardingImage)
        view.addSubview(startButton)
    }
    
    override func setConstraints() {
        contentLabel.snp.makeConstraints { make in
            make.bottom.equalTo(onboardingImage.snp.top).inset(-89)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        onboardingImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(13)
        }
        
        startButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }


}

