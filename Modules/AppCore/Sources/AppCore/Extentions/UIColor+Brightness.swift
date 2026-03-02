//
//  File.swift
//
//
//  Created by Александр Милейчик on 6/24/25.
//

import UIKit

public extension UIColor {
    
    func adjustBrightness(by percentage: CGFloat) -> UIColor? {
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else {
            return nil
        }
        
        let newBrightness = min(max(brightness + percentage, 0.0), 1.0)
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
}
