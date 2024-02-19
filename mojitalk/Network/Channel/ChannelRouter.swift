//
//  ChannelRouter.swift
//  mojitalk
//
//  Created by 이은서 on 2/20/24.
//

import Foundation
import Moya

enum ChannelRouter {
    case create(id: Int, data: Create.Request)
    case fetch(id: Int)
    case fetchJoined(id: Int)
    case pushChat(id: Int, name: String)
    case fetchChat(id: Int, name: String)
    case unreadChat(id: Int, name: String, date: String)
}

extension ChannelRouter: TargetType {
    var baseURL: URL {
        if let url = URL(string: Secret.BaseURL + "/v1/workspaces") {
            return url
        } else {
            print("유효하지 않은 url")
            return URL(string: "https://www.apple.com/kr/")!
        }
    }
    
    var path: String {
        switch self {
        case .create(let id, _):
            "/\(id)/channels"
        case .fetch(let id):
            "/\(id)/channels"
        case .fetchJoined(let id):
            "/\(id)/channels/my"
        case .pushChat(let id, let name):
            "/\(id)/channels/\(name)"
        case .fetchChat(let id, let name):
            "/\(id)/channels/\(name)"
        case .unreadChat(let id, let name, _):
            "/\(id)/channels/\(name)/unread"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create:
            return .post
        case .fetch, .fetchJoined:
            return .get
        case .pushChat(let id, let name):
            return .post
        case .fetchChat, .unreadChat:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .create(let id, let data):
            return .requestJSONEncodable(data)
        case .fetch, .fetchJoined:
            return .requestPlain
        case .pushChat(let id, let name):
            return .uploadMultipart([])
        case .fetchChat(let id, let name):
            return .requestPlain
        case .unreadChat(let id, let name, let date):
            return .requestParameters(parameters: ["after": date], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["SesacKey": Secret.APIKey]
    }
    
    var validationType: ValidationType {
        .successCodes
    }

}
