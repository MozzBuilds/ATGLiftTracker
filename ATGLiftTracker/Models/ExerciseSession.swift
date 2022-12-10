//
//  ExerciseSession.swift
//  ATGLiftTracker
//
//  Created by Colin Morrison on 10/12/2022.
//

import Foundation

struct ExerciseSession {
    
    //TODO: - Date or nah? Probably be another object, which I then convert to a date, or string
    let date: Date
    let entries: [ExerciseSessionEntry]
    
    init(date: Date, entries: [ExerciseSessionEntry]) {
        self.date = date
        self.entries = entries
    }
}
