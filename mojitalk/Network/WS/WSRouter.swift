//
//  WSRouter.swift
//  mojitalk
//
//  Created by 이은서 on 2/7/24.
//

import Foundation
import Moya

enum WSRouter {
    case create(Data, name: String, desc: String?)
    case fetch
    case fetchOne(id: String)
    case edit(id: String)
    case delete(id: String)
    case invite(id: String, data: Member.InviteRequest)
    case fetchMember(id: String)
    case targetMember(id: String, userID: String)
    case search(id: String, keyword: String)
    case leave(id: String)
    case changeAdmin(id: String, userID: String)
    case image(path: String)
}

extension WSRouter: TargetType {
    var baseURL: URL {
        if let url = URL(string: Secret.BaseURL + "/v1") {
            return url
        } else {
            print("유효하지 않은 url")
            return URL(string: "https://www.apple.com/kr/")!
        }
    }
    
    var path: String {
        switch self {
        case .create, .fetch:
            "/workspaces"
        case .image(let path):
            "\(path)"
        case .fetchOne(let id):
            "/workspaces/\(id)"
        case .edit(let id):
            "/workspaces/\(id)"
        case .delete(let id):
            "/workspaces/\(id)"
        case .invite(let id, _):
            "/workspaces/\(id)/members"
        case .fetchMember(let id):
            "/workspaces/\(id)/members"
        case .targetMember(let id, let userID):
            "/workspaces/\(id)/members/\(userID)"
        case .search(let id, let keyword):
            "/workspaces\(id)/search/?keyword=\(keyword)"
        case .leave(let id):
            "/workspaces\(id)/leave"
        case .changeAdmin(let id, let userID):
            "/workspaces\(id)/change/admin/\(userID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create, .invite:
            return .post
        case .fetch, .fetchOne, .fetchMember, .targetMember, .search, .leave, .image:
            return .get
        case .edit, .changeAdmin:
            return .put
        case .delete:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .create(let data, let name, let desc):
            let image = MultipartFormData(provider: .data(data), name: "image", fileName: "profile.jpeg", mimeType: "image/jpeg")
            let name = MultipartFormData(provider: .data(name.data(using: .utf8)!), name: "name")
            if let desc {
                let descData = MultipartFormData(provider: .data(desc.data(using: .utf8)!), name: "description")
                return .uploadMultipart([image, name, descData])
            }
            let multipartData = [image, name]
            return .uploadMultipart(multipartData)
        case .fetch, .fetchOne, .delete, .fetchMember, .targetMember, .leave, .search, .changeAdmin, .image:
            return .requestPlain
        case .edit(let id):
            return .uploadMultipart([])
        case .invite(_, let data):
            return .requestJSONEncodable(data)
        }
    }
    
    var headers: [String : String]? {
        return ["SesacKey": Secret.APIKey]
        
    }
    
    var validationType: ValidationType {
        .successCodes
    }

}
