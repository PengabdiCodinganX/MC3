//
//  MeditationModel.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 19/07/23.
//

import Foundation

struct MeditationModel{
    let id: UUID = UUID()
    let title: String
    let duration: TimeInterval
    let track: String
    
    static let data = MeditationModel(title: "1 Minute Relaxing Meditation", duration: 70, track: "meditation-1")
}
