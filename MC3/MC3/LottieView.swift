//
//  LottieView.swift
//  TestLottie
//
//  Created by Muhammad Rezky on 20/07/23.
//
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var lottieFile:  String
    var loopMode: LottieLoopMode = .playOnce

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        uiView.subviews.forEach({ $0.removeFromSuperview() })
        let animationView = LottieAnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        uiView.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor)
        ])

        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleToFill
        animationView.loopMode = loopMode
        animationView.play()
    }
}
