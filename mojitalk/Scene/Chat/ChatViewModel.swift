//
//  ChannelViewModel.swift
//  mojitalk
//
//  Created by 이은서 on 2/26/24.
//

import Foundation

class ChatViewModel {
    
    let repository = ChatRepository()
    
    var wsID: Int?
    var chName: String?
    var channelInfo: Channel?
    
    func chatModel() -> [ChatTableModel] {
        guard let channelInfo else { return [] }
        
        let repoData = repository.fetchFilter(channel: channelInfo.channelID)
        var result: [ChatTableModel] = []
        
        for item in repoData {
            result.append(.init(name: item.user?.nickname ?? "이름없음", content: item.content, date: dateForChatView(item.date)))
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
    
    func fetchChannelInfo() {
        guard let wsID, let chName else { return }
        ChannelNetworkManager.shared.request(endpoint: .fetchChat(id: wsID, name: chName), type: Channel.self) { result in
            switch result {
            case .success(let success):
                self.channelInfo = success
            case .failure(let failure):
                self.channelInfo = nil
            }
        }
    }
}
