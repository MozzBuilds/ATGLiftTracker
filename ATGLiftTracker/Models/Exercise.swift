//
//  Exercise.swift
//  ATGLiftTracker
//
//  Created by Colin Morrison on 10/12/2022.
//

struct Exercise {
    
    let name: String
    let exerciseSessions: [ExerciseSession]
    
    init(name: String, exerciseSessions: [ExerciseSession]) {
        self.name = name
        self.exerciseSessions = exerciseSessions
    }
}
