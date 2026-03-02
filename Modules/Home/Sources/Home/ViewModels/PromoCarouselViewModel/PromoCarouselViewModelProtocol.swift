//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

public protocol PromoCarouselViewModelProtocol: AnyObject {
    var onPageChange: ((Int) -> Void)? { get set }
    
    func startAutoScroll()
    func stopAutoScroll()
    func didScroll(to fractionalPage: CGFloat)
}
