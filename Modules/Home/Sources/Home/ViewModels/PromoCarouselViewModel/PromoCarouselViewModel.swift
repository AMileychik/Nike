//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/24/25.
//

//import UIKit
//
//import Combine
//
//import DesignSystem
//import AppDomain
//import AppInterface
//import AppCore
//
//
//public final class PromoCarouselViewModel: PromoCarouselViewModelProtocol {
//
//    private let timer: PromoCarouselTimerProtocol
//    private let pages: [PromoPageViewData]
//
//    private let viewDataSubject: CurrentValueSubject<PromoCarouselViewData, Never>
//
//    private let fractionalSubject = CurrentValueSubject<CGFloat, Never>(0)
//
//    private var currentIndex: Int = 0
//    private let autoInterval: TimeInterval
//
//    public init(pages: [PromoPageViewData], timer: PromoCarouselTimerProtocol = DefaultPromoTimer(), autoInterval: TimeInterval = 3.0) {
//        self.timer = timer
//        self.pages = pages
//        self.autoInterval = autoInterval
//        self.viewDataSubject = .init(PromoCarouselViewData(pages: pages))
//    }
//
//    public var onPageChange: ((Int) -> Void)?
//
//    public func startAutoScroll() {
//        guard pages.count > 1 else { return }
//        timer.start(interval: autoInterval) { [weak self] in
//            guard let self = self else { return }
//            self.currentIndex = (self.currentIndex + 1) % self.pages.count
//            self.fractionalSubject.send(CGFloat(self.currentIndex))
//
//            self.onPageChange?(self.currentIndex)
//        }
//    }
//
//    public func stopAutoScroll() {
//        timer.stop()
//    }
//
//    public func didScroll(to fractionalPage: CGFloat) {
//        fractionalSubject.send(fractionalPage)
//        currentIndex = Int(round(fractionalPage))
//    }
//}

import UIKit

import Combine

import DesignSystem
import AppDomain
import AppInterface
import AppCore

// MARK: - PromoCarouselViewModel
///
/// ViewModel for the Promo Carousel section.
/// Handles automatic scrolling, page tracking, and user-driven scrolling.
/// Publishes the current page fraction for UI updates.
public final class PromoCarouselViewModel: PromoCarouselViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let timer: PromoCarouselTimerProtocol
    private let pages: [PromoPageViewData]
    
    // MARK: - State
    
    /// Current view data exposed as a Combine subject
    private let viewDataSubject: CurrentValueSubject<PromoCarouselViewData, Never>
    
    /// Tracks the fractional page for smooth UI transitions
    private let fractionalSubject = CurrentValueSubject<CGFloat, Never>(0)
    
    /// Current integer page index
    private var currentIndex: Int = 0
    
    /// Time interval for automatic scrolling
    private let autoInterval: TimeInterval
    
    // MARK: - Callbacks
    
    /// Notifies external observers about page changes
    public var onPageChange: ((Int) -> Void)?
    
    // MARK: - Initialization
    
    /// - Parameters:
    ///   - pages: Array of pages to display in the carousel
    ///   - timer: Timer for automatic scrolling (default: `DefaultPromoTimer`)
    ///   - autoInterval: Time interval between auto-scrolls (default: 3 seconds)
    public init(
        pages: [PromoPageViewData],
        timer: PromoCarouselTimerProtocol = DefaultPromoTimer(),
        autoInterval: TimeInterval = 3.0
    ) {
        self.timer = timer
        self.pages = pages
        self.autoInterval = autoInterval
        self.viewDataSubject = .init(PromoCarouselViewData(pages: pages))
    }
    
    // MARK: - Auto Scroll
    
    /// Starts automatic scrolling of the carousel.
    public func startAutoScroll() {
        guard pages.count > 1 else { return } // Skip if only one page
        timer.start(interval: autoInterval) { [weak self] in
            guard let self = self else { return }
            self.currentIndex = (self.currentIndex + 1) % self.pages.count
            self.fractionalSubject.send(CGFloat(self.currentIndex))
            
            self.onPageChange?(self.currentIndex)
        }
    }
    
    /// Stops automatic scrolling.
    public func stopAutoScroll() {
        timer.stop()
    }
    
    // MARK: - User Scrolling
    
    /// Updates the current page based on user scrolling.
    /// - Parameter fractionalPage: Fractional page value from the scroll view
    public func didScroll(to fractionalPage: CGFloat) {
        fractionalSubject.send(fractionalPage)
        currentIndex = Int(round(fractionalPage))
    }
}

