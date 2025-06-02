//
//  ProgressView.swift
//  Nike
//
//  Created by Александр Милейчик on 4/3/25.
//

import UIKit

class ProgressView: UIView {
    
    private let backgroundLayer = CALayer()
    private let progressLayer = CALayer()
    private let textLabel = UILabel()
    private let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        drawProgressBar()
    }

    private func setupView() {
        backgroundLayer.backgroundColor = UIColor.lightGray.cgColor
        layer.addSublayer(backgroundLayer)
        
        progressLayer.backgroundColor = UIColor.systemGreen.cgColor
        progressLayer.anchorPoint = CGPoint(x: 0, y: 0.5) 
        layer.addSublayer(progressLayer)

        textLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        textLabel.text = "1%"
        addSubview(textLabel)

        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "Screen readiness progress"
        addSubview(descriptionLabel)
    }
    
    private func drawProgressBar() {
        let barHeight: CGFloat = 8
        let barY = (bounds.height - barHeight) / 2

        backgroundLayer.frame = CGRect(x: 0, y: barY, width: bounds.width, height: barHeight)
        backgroundLayer.cornerRadius = 4

        progressLayer.frame = CGRect(x: 0, y: barY, width: 0, height: barHeight)
        progressLayer.cornerRadius = 4

        textLabel.frame = CGRect(x: bounds.width / 2 - 25, y: barY - 24, width: 50, height: 20)
        descriptionLabel.frame = CGRect(x: 0, y: barY + 14, width: bounds.width, height: 20)
    }

    func animateProgress(to percentage: CGFloat) {
        let duration: CFTimeInterval = 2.0
        let targetWidth = bounds.width * percentage

        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)

        let widthAnimation = CABasicAnimation(keyPath: "bounds.size.width")
        widthAnimation.toValue = targetWidth
        widthAnimation.duration = duration
        widthAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        widthAnimation.fillMode = .forwards
        widthAnimation.isRemovedOnCompletion = false

        progressLayer.add(widthAnimation, forKey: "widthAnimation")

        CATransaction.commit()
        progressLayer.bounds.size.width = targetWidth

        let targetValue = Int(percentage * 100)
        var currentValue = 1
        let stepTime = duration / Double(targetValue)

        Timer.scheduledTimer(withTimeInterval: stepTime, repeats: true) { timer in
            DispatchQueue.main.async {
                self.textLabel.text = "\(currentValue)%"
            }
            if currentValue >= targetValue {
                timer.invalidate()
            }
            currentValue += 1
        }
    }
}
