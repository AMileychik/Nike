//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/20/25.
//

import UIKit

// MARK: - Generic Base View Controller
///
/// Provides a reusable foundation for screens built with composition.
/// Contains one main ContentView and sets up its layout and lifecycle automatically.
/// Minimize duplication and provide a predictable UI.

open class BaseViewController<
    ContentView: UIView
>: UIViewController {
    
    // MARK: - Properties
    
    public let contentView: ContentView
        
    // MARK: - Initialization
    
    public init(
        contentView: ContentView
    ) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Not supported from storyboard/XIB
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
    }
}

// MARK: - Layout

extension BaseViewController {
    
    /// Adds the content view to the hierarchy
    open func setupViews() {
        view.addSubview(contentView)
    }

    /// Pins the content view to the edges of the safe area
    open func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
