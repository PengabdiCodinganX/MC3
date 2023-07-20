//
//  MeditationViewModel.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 19/07/23.
//

import Foundation

class MeditationViewModel: ObservableObject{
    private (set) var meditation: MeditationModel
//
    init(meditation: MeditationModel) {
        self.meditation = meditation
    }
}
