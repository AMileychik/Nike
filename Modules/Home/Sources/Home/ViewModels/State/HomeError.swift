//
//  HomeViewModelEvents.swift
//  Nike
//
//  Created by Александр Милейчик on 5/30/25.
//

import UIKit
import AppDomain

public enum HomeError: Equatable {
    case network
    case decoding
    case cancelled
    case unknown
    
    var message: String {
        switch self {
        case .network: return "No internet connection"
        case .decoding: return "Something went wrong"
        case .cancelled: return ""
        case .unknown: return "Unexpected error"
        }
    }
    
    var hasMessage: Bool {
        !message.isEmpty
    }
}








