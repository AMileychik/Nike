//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//
//
import Foundation

public protocol PromoCarouselTimerProtocol: AnyObject {
    func start(interval: TimeInterval, handler: @escaping () -> Void)
    func stop()
}

