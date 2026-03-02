//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/29/25.
//

import UIKit

import AppDomain
import AppInterface

public final class IndicatorView: UIView {

    private var indicators: [UIView] = []
    private var blackLayers: [UIView] = []

    private let indicatorWidth: CGFloat = 15
    private let indicatorHeight: CGFloat = 2
    private let spacing: CGFloat = 4

    private var pagesCount: Int = 0

    public func configure(pagesCount: Int) {
        self.pagesCount = pagesCount
        indicators.forEach { $0.removeFromSuperview() }
        indicators.removeAll()
        blackLayers.removeAll()

        guard pagesCount > 0 else { return }

        for i in 0..<pagesCount {
            let track = UIView()
            track.translatesAutoresizingMaskIntoConstraints = false
            track.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
            addSubview(track)

            let black = UIView()
            black.translatesAutoresizingMaskIntoConstraints = false
            black.backgroundColor = .clear
            track.addSubview(black)

            indicators.append(track)
            blackLayers.append(black)

            NSLayoutConstraint.activate([
                track.widthAnchor.constraint(equalToConstant: indicatorWidth),
                track.heightAnchor.constraint(equalToConstant: indicatorHeight),
                track.centerYAnchor.constraint(equalTo: centerYAnchor),
                track.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: CGFloat(i) * (indicatorWidth + spacing))
            ])

            if i == 0 {
                black.backgroundColor = .black
                black.frame = CGRect(x: 0, y: 0,
                                     width: indicatorWidth,
                                     height: indicatorHeight)
            } else {
                black.frame = CGRect(x: 0, y: 0,
                                     width: 0,
                                     height: indicatorHeight)
            }
        }
    }

    public func setProgress(_ fractionalPage: CGFloat) {
        guard pagesCount > 1 else { return }

        for index in 0..<pagesCount {
            let track = indicators[index]
            let black = blackLayers[index]

            let fullWidth = track.bounds.width
            let currentIndex = Int(fractionalPage)

            if index == currentIndex {
                let progress = fractionalPage - CGFloat(index)
                black.frame.origin.x = fullWidth * progress
                black.frame.size.width = fullWidth * (1 - progress)
                black.backgroundColor = .black

            } else if index == currentIndex + 1 {
                let progress = fractionalPage - CGFloat(index) + 1
                black.frame.origin.x = 0
                black.frame.size.width = fullWidth * progress
                black.backgroundColor = .black

            } else {
                black.frame.size.width = 0
                black.backgroundColor = .clear
            }
        }
    }
}
