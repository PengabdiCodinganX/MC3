//
//  SoundModel.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 24/07/23.
//

import Foundation

enum SoundType{
    case meditation
    case motivation
}

struct SoundModel{
    let id: UUID = UUID()
    let soundType: SoundType
    var track: String {
        switch soundType {
        case .meditation:
            return "meditation"
        case .motivation:
            return "motivation"
        }
    }
}
