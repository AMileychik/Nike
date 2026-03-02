//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/20/25.
//

import UIKit

open class BaseViewController<
    ContentView: UIView
>: UIViewController {
    
    public let contentView: ContentView
    
    public init(
        contentView: ContentView
    ) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

// MARK: - Layout

private extension BaseViewController {
    func setupViews() {
        view.addSubview(contentView)
    }

    func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}



