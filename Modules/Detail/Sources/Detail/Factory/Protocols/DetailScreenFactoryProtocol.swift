//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/31/25.
//

import UIKit

public protocol DetailScreenFactoryProtocol: AnyObject {
    func createDetailScreen(viewModel: DetailViewModelProtocol) -> DetailViewController 
    func createComingSoonScreen() -> UIViewController
}
