//
//  ExerciseSessionEntry.swift
//  ATGLiftTracker
//
//  Created by Colin Morrison on 10/12/2022.
//

import Foundation

struct ExerciseSessionEntry {
    
    let weight: Decimal
    let reps: Int
    let sets: Int
    
    init(weight: Decimal, reps: Int, sets: Int) {
        self.weight = weight
        self.reps = reps
        self.sets = sets
    }
}
