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
    
    func fetchFilter(channel: Int) -> Results<ChatTable> {
        
        let data = realm.objects(ChatTable.self).where {
            $0.channelID == channel
        }
        return data.sorted(byKeyPath: "date", ascending: true)
        
    }
    
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
