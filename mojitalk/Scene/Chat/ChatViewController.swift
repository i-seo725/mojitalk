//
//  ChatViewController.swift
//  mojitalk
//
//  Created by 이은서 on 2/21/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ChatViewController: BaseViewController, UIScrollViewDelegate {
    
    lazy var chatTableView = UITableView()
    
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
    
    let viewModel = ChatViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        view.backgroundColor = .backgroundSecondary
        view.addSubview(chatTableView)
        view.addSubview(typingView)
        typingView.addSubview(plusButton)
        typingView.addSubview(textField)
        typingView.addSubview(sendButton)
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    override func setConstraints() {
        chatTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(typingView.snp.top).offset(8)
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
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .brandBlack

        let listButton = UIBarButtonItem(image: .list, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = listButton
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.navigationItem.titleView = self.attributeTitleView()
        }
    }
    
    func attributeTitleView() -> UIView {
        let label: UILabel = UILabel()
        var chName = "기타"
        var chMembers = "1"
        
        if let name = viewModel.chName, let members = viewModel.channelInfo?.channelMembers {
            chName = name
            chMembers = "\(members.count)"
        }
        
        let blackText: NSMutableAttributedString = NSMutableAttributedString(string: "#" + (chName), attributes: [.foregroundColor: UIColor.brandBlack])
        let grayText: NSMutableAttributedString =
        NSMutableAttributedString(string: chMembers, attributes: [.foregroundColor: UIColor.textSecondary])
        let space: NSAttributedString = NSAttributedString(string: " ")
        let naviTitle: NSMutableAttributedString = blackText
        naviTitle.append(space)
        naviTitle.append(grayText)
        label.attributedText = naviTitle
        
        return label
    }
    
    func configureTableView() {
        chatTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "cell")
        chatTableView.rowHeight = 70//UITableView.automaticDimension
        chatTableView.rx.setDelegate(self).disposed(by: disposeBag)
        chatTableView.separatorStyle = .none
        
        let model = [ChatTableModel(name: "dddddddddddddddddddddddddddddddddddddddddddddddddddd", content: "adsfadf", date: "\(Date())"),
                     ChatTableModel(name: "은서", content: "은서은서은서 은서은서은서 은서은서은서 은서은서은서 은서은서은서 은서은서은서 은서은서은서 은서은서은서 은서은서은서 은서은서은서 은서은서은서 은서은서은서 은서은서은서 은서은서은서 ads!@#ㄴ리마ㅓㄹ1fadf", date: "\(Date())"),
                     ChatTableModel(name: "은", content: "ads13092댜ㅓㅏㅣㄴfadf", date: "\(Date())"),
                     ChatTableModel(name: "은", content: "ads13092댜ㅓㅏㅣㄴfadf", date: "\(Date())"),
                     ChatTableModel(name: "은", content: "ads13092댜ㅇ139!!@#!@#", date: "\(Date())"),
                     ChatTableModel(name: "은", content: "141ㅕㅐ멀댜ㅓㅏㅣㄴfadf", date: "\(Date())")
        ]
        
        let modelObservable = Observable.of(model.map { $0 })
        
        viewModel.chatModel
            .asDriver()
            .drive(chatTableView.rx.items) { tableView, indexPath, item in
                if let cell = self.chatTableView.dequeueReusableCell(withIdentifier: "cell") as? ChatTableViewCell {
                    cell.nameLabel.text = item.name
                    cell.profileImage.image = item.image
                    cell.contentLabel.text = item.content
                    cell.dateLabel.text = item.date
                    
                    return cell
                } else {
                    let cell = UITableViewCell()
                    cell.backgroundColor = .gray
                    return cell
                }
            }
            .disposed(by: disposeBag)
        
//        Observable.just(viewModel.chatModel)
//            .bind(to: chatTableView.rx.items) { tableView, indexPath, item in
//                
////                tableView.estimatedRowHeight = 100
////                tableView.rowHeight = UITableView.automaticDimension
//                
//                if let cell = self.chatTableView.dequeueReusableCell(withIdentifier: "cell") as? ChatTableViewCell {
//                    cell.nameLabel.text = item.name
//                    cell.profileImage.image = item.image
//                    cell.contentLabel.text = item.content
////                    cell.dateLabel.text = item.date
//                    
//                    return cell
//                } else {
//                    let cell = UITableViewCell()
//                    cell.backgroundColor = .gray
//                    return cell
//                }
//            }
//            .disposed(by: disposeBag)
            

    }
    
    override func bind() {
        textField.rx.text.orEmpty
            .map{ $0.isEmpty }
            .bind(with: self) { owner, value in
                let image = value ? UIImage.sendEmpty : UIImage.send
                owner.sendButton.setImage(image, for: .normal)
            }
            .disposed(by: disposeBag)
    }
}
