//
//  LottieAnimationManager.swift
//  Project-E
//
//  Created by Shumakov Dmytro on 23.08.2022.
//

import UIKit
import Lottie

extension UIView {
    
    // MARK: - Lottie Animation Names
    
    static var lottie_gradient_loader = Animation.named("gradient-stroke-loader")
    
    
    // MARK: - Lottie Animation Methods
    
    func startAnimation() {
        let backgroundView = UIView()
        backgroundView.tag = 1010
        backgroundView.frame = self.bounds
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.alpha = 0.8
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let animationView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        let animation = AnimationView(animation: UIView.lottie_gradient_loader)
        animation.contentMode = .scaleAspectFill
        animation.loopMode = .loop
        animation.play()
        animation.frame = animationView.bounds
        
        animationView.addSubview(animation)
        animationView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        //
        backgroundView.insertSubview(blurEffectView, at: 0)
        backgroundView.insertSubview(animationView, at: 1)
        //
        self.addSubview(backgroundView)
        
    }
    
    func stopAnimation() {
        if let view = self.viewWithTag(1010) {
            view.removeFromSuperview()
        }
    }
}

