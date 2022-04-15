//
//  RealmManager.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published private(set) var times:[Times] = []
    var dates: [Times]{
        times.filter { $0.date == ""}
    }
    
    init () {
        openRealm()
        getTimes()
    }
    
    func openRealm() {
        do{
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm  = try Realm()
        }catch{
            print("Error opening Realm: \(error)")
        }
    }
    
    
    func addTime(startTime: String, duration: Int, date: String, xDuration: Int?) {
        
        if let localRealm = localRealm {
            do{
                try localRealm.write{
                    let newTime = Times(value: ["startTime": startTime, "duration": duration, "date": date, "xDuration": xDuration ?? nil])
                    localRealm.add(newTime)
                    getTimes()
                }
            }catch {
                print("Error saving time: \(error)")
            }
        }
        
    }
    
    
    func getTimes() {
        if let localRealm = localRealm {
            let allTimes = localRealm.objects(Times.self).sorted(byKeyPath: "id", ascending: false)
            times = []
            allTimes.forEach { time in
                times.append(time)
            }
        }
    }
    
    func deleteTimes(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let timeToDelete = localRealm.objects(Times.self).filter(NSPredicate(format: "id == %@", id))
                guard !timeToDelete.isEmpty else { return }
                
                try localRealm.write{
                    localRealm.delete(timeToDelete)
                    getTimes()
                }
            }catch {
                print("Error deleting time from Realm: \(error)")
            }
        }
    }
}
