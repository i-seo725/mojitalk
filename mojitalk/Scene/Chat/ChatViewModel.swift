//
//  ChannelViewModel.swift
//  mojitalk
//
//  Created by 이은서 on 2/26/24.
//

import Foundation
import RxSwift
import RxCocoa

class ChatViewModel {
    
    let chatRepo = ChatRepository()
    let userRepo = UserRepository()
    
    var wsID: Int?
    var chName: String?
    
    var handler: (() -> Void)?
    var channelInfo: Channel? {
        didSet {
            chatModel.accept(fetchChatModel())
        }
    }
    var chatInfo: Chat?
    
    lazy var chatModel = BehaviorRelay(value: fetchChatModel())
    
    func fetchChatModel() -> [ChatTableModel] {
        guard let channelInfo else { return [] }
        let chatRepoData = chatRepo.fetchFilter(channel: channelInfo.channelID)
        
        var result: [ChatTableModel] = []
        
        for item in chatRepoData {
            if let nickname = userRepo.fetchFilter(user: item.user).first?.nickname, let image = userRepo.fetchFilter(user: item.user).first?.profile {
                result.append(.init(image: image, name: nickname, content: item.content, date: dateForChatView(item.date)))
            } else {
                continue
            }
        }
        
        return result
    }
    
    func dateForChatView(_ date: Date) -> String {
        
        let dbDate = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        
        let isToday = dbDate.year == today.year && dbDate.month == today.month && dbDate.day == today.day ? true : false
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "ko_KR")
        
        switch isToday {
        case true:
            dateFormatter.dateFormat = "hh:mm a"
        case false:
            dateFormatter.dateFormat = "M/dd\nhh:mm a"
        }
        
        return dateFormatter.string(from: date)
    }
    
    func stringToDate(_ date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "ko_KR")
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let result = dateFormatter.date(from: date)
        return result
    }
    
    func fetchChannelInfo() {
        guard let wsID, let chName else { return }
        ChannelNetworkManager.shared.request(endpoint: .fetchChat(id: wsID, name: chName, date: ""), type: Channel.self) { result in
            switch result {
            case .success(let success):
                self.channelInfo = success
            case .failure(_):
                self.channelInfo = nil
            }
        }
    }
    
    func fetchUserInfo(chatinfo: Chat, handler: @escaping (UserInfo) -> Void) {
        let userID = chatinfo.user.userID
        UserNetworkManager.shared.request(endpoint: .users(id: userID), type: UserInfo.self) { result in
            switch result {
            case .success(let success):
                handler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func checkUserWithChat(_ chat: Chat) {
        if self.userRepo.fetchFilter(user: chat.user.userID).isEmpty {
            fetchUserInfo(chatinfo: chat) { user in
                let data = UserTable(id: user.userID, email: user.email, nickname: user.nickname, profile: user.profileImage ?? ("noPhoto" + ["A", "B", "C"].randomElement()!))
                self.userRepo.create(data)
            }
        }
    }
    
    func writeChat(chat: Chat) {
        let user = self.userRepo.fetchFilter(user: chat.user.userID)
        
        guard let date = self.stringToDate(chat.createdAt), let content = chat.content, let userID = user.first?.id else { return }
        let data = ChatTable(chatID: chat.chatID, channelID: chat.channelID, channelName: chat.channelName, content: content, date: date, user: userID)
        
        chatRepo.create(data)
        chatModel.accept(fetchChatModel())
    }
    
    func sendMessageAPI(_ content: String) {
        guard let channelInfo else { return }
        
        ChannelNetworkManager.shared.request(endpoint: .pushChat(id: channelInfo.wsID, name: channelInfo.name, content: content, files: Data()), type: Chat.self) { [self] result in
            switch result {
            case .success(let success):
                self.checkUserWithChat(success)
                self.writeChat(chat: success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchChat() {
        guard let channelInfo else { return }
        ChannelNetworkManager.shared.request(endpoint: .fetchChat(id: channelInfo.channelID, name: channelInfo.name, date: ""), type: Chat.self) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
