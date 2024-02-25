//
//  ChatRepository.swift
//  mojitalk
//
//  Created by 이은서 on 2/26/24.
//

import Foundation
import RealmSwift

final class ChatRepository {
    
    private let realm = try! Realm()
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: ", version)
        } catch {
            print(error)
        }
    }
    
    func fetch() -> Results<ChatTable> {
        let data = realm.objects(ChatTable.self)
        return data
    }
    
    //현재로부터 몇개씩 불러오기?
//    func fetchFilter(date: Date) -> Results<ChatTable>? {
//        if let startDay = date.dateToString().stringToDate() {
//            let endDay = startDay.addingTimeInterval(86400)
//            
//            let data = realm.objects(MainList.self).where {
//                $0.date >= startDay && $0.date < endDay && $0.group == group
//            }
//            
//            return data.sorted(byKeyPath: "isDone")
//        } else {
//            return nil
//        }
//    }
    
    func create(_ item: ChatTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
}
