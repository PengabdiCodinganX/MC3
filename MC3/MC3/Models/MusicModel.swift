//
//  MusicModel.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 24/07/23.
//

import Foundation

enum MusicType{
    case meditation
    case motivation
}

struct MusicModel{
    let id: UUID = UUID()
    let musicType: MusicType
    var track: String {
        switch musicType {
        case .meditation:
            return "meditation"
        case .motivation:
            return "motivation"
        }
    }
}
