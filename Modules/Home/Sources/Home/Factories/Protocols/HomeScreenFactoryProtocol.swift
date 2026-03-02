//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import UIKit

import SharedUI

public protocol HomeScreenFactoryProtocol: AnyObject {
    func createHomeScreen(
        viewModel: HomeViewModelProtocol
    ) -> UIViewController & HomeViewDisplayingProtocol
    
    func createComingSoonScreen() -> ComingSoonViewController
}
