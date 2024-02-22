//
//  ChatViewController.swift
//  mojitalk
//
//  Created by 이은서 on 2/21/24.
//

import UIKit
import RxSwift
import RxCocoa

class ChatViewController: BaseViewController {
    
    lazy var chatCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 16, left: 16, bottom: 8, right: 16)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: view.frame.width - 32, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    let typingView = {
        let view = UIView()
        view.backgroundColor = .backgroundPrimary
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    let plusButton = {
        let view = UIButton()
        let image = UIImage(named: "plusIcon")?.withRenderingMode(.alwaysTemplate)
        view.setImage(image, for: .normal)
        view.tintColor = .textSecondary
        return view
    }()
    let textField = {
        let view = UITextField()
        view.borderStyle = .none
        view.attributedPlaceholder = NSAttributedString(string: "메세지를 입력하세요", attributes: [.foregroundColor: UIColor.textSecondary])
        view.font = Font.body
        view.textColor = .textPrimary
        return view
    }()
    let sendButton = {
        let view = UIButton()
        view.setImage(.sendEmpty, for: .normal)
        return view
    }()
    
    var members = " 1"
    var channelName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatCollectionView.dataSource = self
    }
    
    override func configureView() {
        configureNavBar()
        
        view.backgroundColor = .backgroundSecondary
        view.addSubview(chatCollectionView)
        view.addSubview(typingView)
        typingView.addSubview(plusButton)
        typingView.addSubview(textField)
        typingView.addSubview(sendButton)
        
        chatCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func setConstraints() {
        chatCollectionView.snp.makeConstraints { make in
            make.size.equalTo(view.safeAreaLayoutGuide)
        }
        
        typingView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.greaterThanOrEqualTo(38)
        }
        
        plusButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.equalTo(22)
            make.height.equalTo(20)
        }
        
        textField.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalTo(plusButton.snp.trailing).offset(8)
        }
        
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
    
    func configureNavBar() {
        guard let channelName else { return }
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .brandBlack
        title = "#" + channelName + members
        
        
        navigationItem.titleView = attributeTitleView()
        let attributedStr = NSMutableAttributedString(string: title!)

        // text의 range 중에서 "Bonus"라는 글자는 UIColor를 blue로 변경
        attributedStr.addAttribute(.foregroundColor, value: UIColor.textSecondary, range: (title! as NSString).range(of: "#" + channelName))
        // text의 range 중에서 "Point"라는 글자는 UIColor를 orange로 변경
        attributedStr.addAttribute(.foregroundColor, value: UIColor.brandBlack, range: (title! as NSString).range(of: members))

        
        let listButton = UIBarButtonItem(image: .list, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = listButton
    }
    
    func attributeTitleView() -> UIView {
            let label: UILabel = UILabel()
        let blackText: NSMutableAttributedString = NSMutableAttributedString(string: "#" + (channelName ?? "일반"), attributes: [.foregroundColor: UIColor.brandBlack])
            let grayText: NSMutableAttributedString =
            NSMutableAttributedString(string: members, attributes: [.foregroundColor: UIColor.textSecondary])
            
            let naviTitle: NSMutableAttributedString = blackText
            naviTitle.append(grayText)
            label.attributedText = naviTitle
            
            return label
    }
}

extension ChatViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
}
