//
//  ViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/3/24.
//

import UIKit
import RxSwift
import RxCocoa

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
    
    let startButton = ImageButton(frame: .zero, image: .active)
    
    let bgView = UIView()
    var nextButtonTapped = BehaviorRelay<Bool>(value: false)

    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(contentLabel)
        view.addSubview(onboardingImage)
        view.addSubview(bgView)
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
        
        bgView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    override func bind() {
        startButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.bgView.backgroundColor = .alpha
                owner.nextButtonTapped.accept(true)
                owner.startButton.isHidden = true
                
                let vc = ContinueViewController()
                vc.modalPresentationStyle = .pageSheet
                vc.sheetPresentationController?.prefersGrabberVisible = true
                vc.isDisappear = { value in
                    owner.nextButtonTapped.accept(!value)
                }
                
                guard let sheet = vc.sheetPresentationController else { return }
                if #available(iOS 16.0, *) {
                    sheet.detents = [.custom(resolver: { context in
                        return 269
                    })]
                } else {
                    sheet.detents = [.medium()]
                }
                
                
                owner.present(vc, animated: true)
            })

            .disposed(by: disposeBag)
        
        nextButtonTapped
            .bind(with: self) { owner, value in
                owner.bgView.backgroundColor = value ? .alpha : .clear
                owner.startButton.isHidden = value
            }
            .disposed(by: disposeBag)
    }


}

