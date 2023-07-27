//
//  LottieController.swift
//  MC3
//
//  Created by Muhammad Rezky on 27/07/23.
//

import SwiftUI
import Lottie

class LottieController: ObservableObject {
    var animationView: LottieAnimationView? = nil
    
    func play() {
        animationView?.play()
    }
    
    func pause() {
        animationView?.pause()
    }
}
