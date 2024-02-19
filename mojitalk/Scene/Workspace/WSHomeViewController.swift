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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let sections = [
            CustomSection(header: "채널", items: [CellModel(text: "일반", image: .hashtagThick), CellModel(text: "기타", image: .hashtagThin)]),
            CustomSection(header: "다이렉트 메시지", items: [CellModel(text: "비어 있음", image: .plusIcon)])
            ]
        
        Observable.just(sections)
            .bind(to: listTableView.rx.items(dataSource: dataSource))
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
                    self.requestChannel()
                    
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
    
    func requestChannel() {
        guard let currentID else { return }
        
        WSNetworkManager.shared.request(endpoint: .fetchOne(id: currentID), type: FetchOne.Response.self) { result in
            switch result {
            case .success(let success):
                print(success)
                self.currentWS = success
            case .failure(let failure):
                print("현재 워크스페이스 정보 가져오기 실패")
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
