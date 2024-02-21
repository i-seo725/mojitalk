//
//  WSHomeViewController.swift
//  mojitalk
//
//  Created by 이은서 on 2/12/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class WSHomeViewController: BaseViewController {
    
    let customNavBar = CustomNavigationBar()
    let listTableView = UITableView()
    let disposeBag = DisposeBag()
    
    var currentID: Int?
    var currentWS: FetchOne.Response?
    
    var myChannels = CustomSection(header: "채널", items: [CellModel(text: "채널 추가", image: .plusIcon)])
    var myDMs = CustomSection(header: "다이렉트 메시지", items: [CellModel(text: "새 메시지 보내기", image: .plusIcon)])
    
    lazy var model = BehaviorRelay(value: [myChannels, myDMs])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(channelAddViewDismissed), name: NSNotification.Name("dismissChannelAddView"), object: nil)
    }
    
    @objc func channelAddViewDismissed() {
        requestChannel()
    }
    
    override func configureView() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .backgroundSecondary
        view.addSubview(customNavBar)
        view.addSubview(listTableView)
        configureTableView()
        requestWS()
    }
    
    override func setConstraints() {
        customNavBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(98)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureTableView() {
        listTableView.register(WSListTableViewCell.self, forCellReuseIdentifier: "cell")
        listTableView.rowHeight = 41
        listTableView.sectionHeaderHeight = 56
        listTableView.delegate = self
        listTableView.separatorStyle = .none
        
        let dataSource = RxTableViewSectionedReloadDataSource<CustomSection> { datasource, tableView, indexPath, item in
            
            guard let cell = self.listTableView.dequeueReusableCell(withIdentifier: "cell") as? WSListTableViewCell else {
                print("d")
                return UITableViewCell()
            }
            
            tableView.sectionHeaderTopPadding = .zero
            cell.titleLabel.text = item.text
            cell.setImageView.image = UIImage(named: item.image.rawValue)
            
            return cell
        }
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        

        model
            .asDriver()
            .drive(listTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
        Observable.zip(listTableView.rx.modelSelected(CellModel.self), listTableView.rx.itemSelected)
            .bind(with: self, onNext: { owner, data in
                if data.1.row == owner.myChannels.items.count - 1 {
                    let vc = WSAddViewController()
                    vc.viewCase = .channel
                    vc.wsID = owner.currentID
                    vc.profileImage.isHidden = true
                    vc.bubbleImage.isHidden = true
                    vc.cameraImage.isHidden = true
                    owner.present(UINavigationController(rootViewController: vc), animated: true)
                } else {
                    owner.navigationController?.pushViewController(WSHomeEmptyViewController(), animated: true)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    func requestWS() {
        WSNetworkManager.shared.request(endpoint: .fetch, type: [WS.Response].self) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    guard let ws = success.first, let url = URL(string: Secret.BaseURL + "/v1" + ws.thumbnail) else { return }
                    self.customNavBar.titleLabel.text = ws.name
                    self.currentID = ws.id
                    self.requestCurrentWS()
                    
                    self.requestImage(path: ws.thumbnail) {
                        self.customNavBar.leftImage.image = $0
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func requestImage(path: String, handler: @escaping (UIImage) -> Void) {
        WSNetworkManager.shared.request(endpoint: .image(path: path)) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    if let image = UIImage(data: success.data) {
                        handler(image)
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func requestCurrentWS() {
        guard let currentID else { return }
        
        WSNetworkManager.shared.request(endpoint: .fetchOne(id: currentID), type: FetchOne.Response.self) { result in
            switch result {
            case .success(let success):
                self.currentWS = success
                self.requestChannel()
            case .failure(let failure):
                print("현재 워크스페이스 정보 가져오기 실패")
            }
        }
    }
    
    func requestChannel() {
        guard let currentID else { return }
        
        ChannelNetworkManager.shared.request(endpoint: .fetchJoined(id: currentID), type: [Channel].self) { result in
            switch result {
            case .success(let success):
                self.myChannels.items = []
                success.forEach { channel in
                    self.myChannels.items.append(.init(text: channel.name, image: .hashtagThin))
                }
                self.myChannels.items.append(.init(text: "채널 추가", image: .plusIcon))
                self.model.accept([self.myChannels, self.myDMs])
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension WSHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = CustomHeader()
            view.titleLabel.text = "채널"
            return view
        case 1:
            let view = CustomHeader()
            view.titleLabel.text = "다이렉트 메시지"
            return view
        default:
            return nil
        }
    }
    
}
