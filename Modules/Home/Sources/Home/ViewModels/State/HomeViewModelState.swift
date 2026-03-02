//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

public enum HomeViewModelState {
    case initial
    case loading
    case loaded
    case error(HomeError)
}
