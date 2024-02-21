//
//  WorkspaceAddViewController.swift
//  mojitalk
//
//  Created by 이은서 on 1/27/24.
//

import UIKit
import PhotosUI
import RxSwift
import RxCocoa

class WSAddViewController: BaseViewController {
    
    enum ViewType: String {
        case ws = "워크스페이스"
        case channel = "채널"
    }
    
    let profileImage = {
        let image = UIImage(named: "DummyProfile")?.withRenderingMode(.alwaysTemplate)
        let view = UIImageView(image: image)
        view.tintColor = .brandGreen
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let bubbleImage = {
        let image = UIImage(named: "Vector")?.withRenderingMode(.alwaysTemplate)
        let view = UIImageView(image: image)
        view.tintColor = .brandWhite
        return view
    }()

    let cameraImage = {
        let image = UIImage(named: "Camera")
        let view = UIImageView(image: image)
        view.tintColor = .brandWhite
        view.layer.borderColor = UIColor.brandWhite.cgColor
        view.layer.borderWidth = 3
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    let clearButton = {
        let view = UIButton()
        view.alpha = 0.02
        return view
    }()
    
    let validLabel = ToastView()
    
    lazy var name = JoinView(title: "\(viewCase.rawValue) 이름", placeholder: "\(viewCase.rawValue) 이름을 입력하세요 (필수)")
    lazy var desc = JoinView(title: "\(viewCase.rawValue) 설명", placeholder: "워크스페이스를 설명하세요 (옵션)")
    let completeButton = TextButton(title: "완료")
    
    var viewCase: ViewType = .ws
    
    var isChangedImage = BehaviorSubject(value: false)
    var selectedImage: UIImage?
    
    var wsID: Int?

    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if viewCase == .channel {
            NotificationCenter.default.post(name: NSNotification.Name("dismissChannelAddView"), object: nil, userInfo: nil)
        }
    }
    
    override func configureView() {
        super.configureView()
        configureNavBar()
        view.addSubview(profileImage)
        view.addSubview(bubbleImage)
        view.addSubview(cameraImage)
        view.addSubview(name)
        view.addSubview(desc)
        view.addSubview(completeButton)
        view.addSubview(clearButton)
        view.addSubview(validLabel)
        name.textField.becomeFirstResponder()
        
        switch viewCase {
        case .ws:
            desc.textField.placeholder = "워크스페이스를 설명하세요 (옵션)"
        case .channel:
            desc.textField.placeholder = "채널을 설명하세요 (옵션)"
        }
    }
    
    func configureNavBar() {
        navigationItem.title = "\(viewCase.rawValue) 생성"
        let closeButton = UIBarButtonItem(image: .closeIcon, style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    override func setConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.centerX.equalToSuperview()
            make.size.equalTo(70)
        }
        
        bubbleImage.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top).inset(10)
            make.horizontalEdges.equalTo(profileImage.snp.horizontalEdges).inset(11)
            make.bottom.equalTo(profileImage.snp.bottom)
        }
        
        cameraImage.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalTo(profileImage.snp.top).inset(51)
            make.leading.equalTo(profileImage.snp.leading).inset(53)
        }
        
        clearButton.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top)
            make.leading.equalTo(profileImage.snp.leading)
            make.bottom.equalTo(cameraImage.snp.bottom)
            make.trailing.equalTo(cameraImage.snp.trailing)
        }
        //트러블슈팅 - UIView 안에 있는 텍스트필드 터치 안 먹음
        //-> 뷰의 높이 지정 안해서 에러 발생, debug view hierarchy로 디버깅
        
        switch viewCase {
        case .ws:
            name.snp.makeConstraints { make in
                make.top.equalTo(profileImage.snp.bottom).offset(16)
                make.horizontalEdges.equalToSuperview().inset(24)
                make.height.equalTo(76)
            }
        case .channel:
            name.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
                make.horizontalEdges.equalToSuperview().inset(24)
                make.height.equalTo(76)
            }
        }
        
        desc.snp.makeConstraints { make in
            make.top.equalTo(name.textField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(76)
        }
        
        completeButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
        
        validLabel.snp.makeConstraints { make in
            make.bottom.equalTo(completeButton.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(36)
        }
        validLabel.sizeToFit()
    }
    
    override func bind() {
        clearButton.rx.tap
            .bind(with: self) { owner, _ in
                var configuration = PHPickerConfiguration()
                configuration.filter = .any(of: [.images, .screenshots])
                
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = owner
                owner.present(picker, animated: true)
            }
            .disposed(by: disposeBag)
        
        let isValidName = BehaviorSubject(value: false)
        
        name.textField.rx.text.orEmpty
            .map { !$0.isEmpty && $0.count <= 30 }
            .observe(on:MainScheduler.asyncInstance)
            .bind(to: isValidName)
            .disposed(by: disposeBag)
        
        let isValidCreate = viewCase == .ws ? Observable.combineLatest(isChangedImage, isValidName) {
            return $0 && $1
        } : isValidName
        
        let completeButtonTapped = Observable.combineLatest(completeButton.rx.tap, isValidCreate)

        
        completeButtonTapped
            .bind(with: self) { owner, value in
                if value.1 {
                    owner.requestWSAdd()
                    owner.dismiss(animated: true)
                } else {
                    owner.showToast(view: owner.validLabel, title: "생성 불가")
                }
                
            }
            .disposed(by: disposeBag)
    }
    
    func requestWSAdd() {
        switch viewCase {
        case .ws:
            guard let dataImage = selectedImage?.jpegData(compressionQuality: 0.3) else { return }
            WSNetworkManager.shared.request(endpoint: .create(dataImage, name: name.textField.text!, desc: desc.textField.text)) { result in
                switch result {
                case .success(let success):
                    print("a")
                case .failure(let failure):
                    print("B")
                }
            }
        case .channel:
            guard let name = name.textField.text, let wsID else { return }
            let data = Create.Request(name: name, description: desc.textField.text ?? "")
            ChannelNetworkManager.shared.request(endpoint: .create(id: wsID, data: data), type: Channel.self) { result in
                switch result {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
        
    }
}

extension WSAddViewController: PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    guard let image = image as? UIImage else { return }
                    self.profileImage.image = image
                    self.cameraImage.isHidden = true
                    self.bubbleImage.isHidden = true
                    self.isChangedImage.onNext(true)
                    self.selectedImage = image
                }
            }
        } else {
            print("실패")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
}
