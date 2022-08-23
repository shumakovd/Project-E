//
//  UIButtonExt.swift
//  Project-E
//
//  Created by Shumakov Dmytro on 23.08.2022.
//

import UIKit

extension UIButton {
        
    func setRoundedLine() {
        if self.traitCollection.userInterfaceStyle == .dark {
            self.borderColorView = .white
        } else {
            self.borderColorView = .black
        }
        
        self.borderWidthView = 1
        self.layer.cornerRadius = 8
    }
}
