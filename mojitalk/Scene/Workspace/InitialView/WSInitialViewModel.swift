//
//  WSInitialViewModel.swift
//  mojitalk
//
//  Created by 이은서 on 3/1/24.
//

import Foundation
import RxSwift
import RxCocoa

class WSInitialViewModel {
    
    func isJoinAnyWS(handler: @escaping (Int) -> Void) {
        
        WSNetworkManager.shared.request(endpoint: .fetch, type: [WS.Response].self) { result in
            switch result {
            case .success(let success):
                handler(success.count)
            case .failure(let failure):
                print("b")
            }
        }

    }
    
}
