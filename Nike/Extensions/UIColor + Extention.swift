//
//  UIColor + Extention.swift
//  Nike
//
//  Created by Александр Милейчик on 1/14/25.
//

import UIKit

extension UIColor {
    
    func adjustBrightness(by percentage: CGFloat) -> UIColor? {
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        guard getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else {
            return nil
        }

        let newBrightness = min(brightness + percentage, 1.0)
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
}

