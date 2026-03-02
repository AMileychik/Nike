//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

import AppInterface

public final class DefaultPromoTimer: PromoCarouselTimerProtocol {
    private var timer: Timer?

    public init() {}

    public func start(interval: TimeInterval, handler: @escaping () -> Void) {
        stop()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in handler() }
    }

    public func stop() {
        timer?.invalidate()
        timer = nil
    }
}
