//
//  Times.swift
//  TrackItMomma
//
//  Created by Andres Gutierrez on 4/14/22.
//

import Foundation
import RealmSwift

class PTimes: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var startTime    = ""
    @Persisted var duration: Int
    @Persisted var date         = ""
    @Persisted var xDuration: Int?
}


class LTime: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var lastFed      = ""
    @Persisted var duration     = ""
    @Persisted var currentDate  = ""
}

