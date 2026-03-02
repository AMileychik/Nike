//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import UIKit

import Combine

import AppDomain
import AppInterface

public protocol HomeViewModelInput: AnyObject {
    func loadProducts()
    func onAppear()
    func sendEvent(_ action: HomeViewModelEvent)
}

public protocol HomeViewModelOutput: AnyObject {
  
    var statePublisher: AnyPublisher<HomeViewModelState, Never> { get }
    var effectPublisher: AnyPublisher<HomeEffect, Never> { get }
    
    func numberOfSections() -> Int
    func section(at index: Int) -> HomeSectionModel?
}

public typealias HomeViewModelProtocol = HomeViewModelInput & HomeViewModelOutput
