//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/29/25.
//

import UIKit

import AppDomain
import AppInterface

protocol IndicatorViewProtocol: UIView {
    func configure(pagesCount: Int)
    func setProgress(_ fractionalPage: CGFloat)
}

public final class IndicatorView: UIView, IndicatorViewProtocol {
    
    // MARK: - Views
    
    private let containerView = UIView()
    
    private var tracks: [UIView] = []
    private var fills: [UIView] = []
    
    // MARK: - State
    
    private var state: IndicatorState?
    private var needsInitialRender = false
    
    // MARK: - Public
    
    public func configure(pagesCount: Int) {
        reset()
        guard pagesCount > 0 else { return }
        
        setupContainerIfNeeded()
        
        let state = IndicatorState(pagesCount: pagesCount, fractionalPage: 0)
        self.state = state
        
        buildIndicators(pagesCount: pagesCount)
        needsInitialRender = true
        setNeedsLayout()
    }
    
    public func setProgress(_ fractionalPage: CGFloat) {
        guard let state else { return }
        render(
            IndicatorState(
                pagesCount: state.pagesCount,
                fractionalPage: fractionalPage
            )
        )
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let state else { return }
        
        containerView.layoutIfNeeded()
        tracks.forEach { $0.layoutIfNeeded() }
        
        render(state)
    }
    
    // MARK: - Private Setup
    
    private func setupContainerIfNeeded() {
        guard containerView.superview == nil else { return }
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func reset() {
        tracks.forEach { $0.removeFromSuperview() }
        tracks.removeAll()
        fills.removeAll()
    }
    
    private func buildIndicators(pagesCount: Int) {
        for index in 0..<pagesCount {
            let track = makeTrack()
            let fill = makeFill()
            
            track.addSubview(fill)
            containerView.addSubview(track)
            
            tracks.append(track)
            fills.append(fill)
            
            NSLayoutConstraint.activate([
                track.widthAnchor.constraint(equalToConstant: IndicatorLayout.indicatorWidth),
                track.heightAnchor.constraint(equalToConstant: IndicatorLayout.indicatorHeight),
                track.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                track.leadingAnchor.constraint(
                    equalTo: containerView.leadingAnchor,
                    constant: CGFloat(index) * (IndicatorLayout.indicatorWidth + IndicatorLayout.spacing)
                )
            ])
        }
        
        let totalWidth =
        CGFloat(pagesCount) * IndicatorLayout.indicatorWidth +
        CGFloat(pagesCount - 1) * IndicatorLayout.spacing
        
        containerView.widthAnchor
            .constraint(equalToConstant: totalWidth)
            .isActive = true
    }
    
    // MARK: - Rendering
    
    private func render(_ state: IndicatorState) {
        
        guard state.pagesCount > 0 else { return }
        guard !tracks.isEmpty else { return }
        
        let currentIndex = Int(state.fractionalPage)
        
        for index in 0..<state.pagesCount {
            let track = tracks[index]
            let fill = fills[index]
            
            let width = track.bounds.width
            
            switch index {
            case currentIndex:
                let progress = state.fractionalPage - CGFloat(index)
                fill.frame = CGRect(
                    x: width * progress,
                    y: 0,
                    width: width * (1 - progress),
                    height: IndicatorLayout.indicatorHeight
                )
                fill.backgroundColor = .black
                
            case currentIndex + 1:
                let progress = state.fractionalPage - CGFloat(index) + 1
                fill.frame = CGRect(
                    x: 0,
                    y: 0,
                    width: width * progress,
                    height: IndicatorLayout.indicatorHeight
                )
                fill.backgroundColor = .black
                
            default:
                fill.frame.size.width = 0
                fill.backgroundColor = .clear
            }
        }
    }
    
    // MARK: - Factory Methods
    
    private func makeTrack() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        return view
    }
    
    private func makeFill() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }
}


