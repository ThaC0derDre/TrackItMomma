//
//  LRealmManager.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import Foundation
import RealmSwift


class LRealmManager : ObservableObject {
    private(set) var localRealm: Realm?
    @Published private(set) var times: [LTime] = []
    
    init() {
        openRealm()
        getTimes()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
        }catch {
            print("Error opening Realm: \(error)" )
        }
    }
        
    
    func addTime(lastFed: String, duration: String, currentDate: String?) {
            if let localRealm = localRealm {
                do {
                    try localRealm.write{
                        let newTime = LTime(value: ["lastFed": lastFed, "duration": duration, "currentDate": currentDate])
                        localRealm.add(newTime)
                        getTimes()
                        print("Added net time to realm \(newTime)")
                    }
                } catch {
                    print("Error adding new time: \(error)")
                }
            }
        }
        
        
        func getTimes() {
            if let localRealm = localRealm {
                let allTimes = localRealm.objects(LTime.self).sorted(byKeyPath: "id", ascending: false)
                times = []
                allTimes.forEach { time in
                    times.append(time)
                }
            }
        }
    
    func deleteTime (id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let timeToDelete = localRealm.objects(LTime.self).filter(NSPredicate(format: "id == %@", id))
                guard !timeToDelete.isEmpty else { return }
                
                try localRealm.write{
                    localRealm.delete(timeToDelete)
                    getTimes()
                }
            }catch {
                print("Error deleting time \(id) from Realm: \(error)")
            }
        }
    }
}
