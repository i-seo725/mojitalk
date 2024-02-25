//
//  UserRepository.swift
//  mojitalk
//
//  Created by 이은서 on 2/26/24.
//

import Foundation
import RealmSwift

final class UserRepository {
    
    private let realm = try! Realm()
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: ", version)
        } catch {
            print(error)
        }
    }
    
    func fetchFilter(channel: Int) -> Results<UserTable> {
        
        let data = realm.objects(UserTable.self)
        return data
        
    }
    
    func create(_ item: UserTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
}
