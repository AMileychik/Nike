//
//  WelcomeCell.swift
//  Nike
//
//  Created by Александр Милейчик on 9/27/25.
//

import UIKit
import DesignSystem

// MARK: - Public

/// UITableViewCell displaying welcome text on Home screen.
final class WelcomeCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let welcomeLabel = Label(type: .screenTitle)
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        welcomeLabel.text = nil
    }
}

// MARK: - Public Methods

extension WelcomeCell {
    
    /// Updates the cell with welcome text
    func configure(with model: WelcomeViewData) {
        welcomeLabel.text = model.text
        welcomeLabel.accessibilityLabel = Constants.accessibilityLabel
        welcomeLabel.isAccessibilityElement = true
    }
}

// MARK: - View Configuration

private extension WelcomeCell {
    
    func configureView() {
        contentView.addSubview(welcomeLabel)
    }
}

// MARK: - Layout

private extension WelcomeCell {
    
    func configureLayout() {
        contentView.directionalLayoutMargins = Constants.layoutMargins
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            welcomeLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

// MARK: - Constants

private enum Constants {
    
    // Layout
    static let layoutMargins = NSDirectionalEdgeInsets(
        top: 20,
        leading: 24,
        bottom: 0,
        trailing: 24
    )
    
    // Accessibility
    static let accessibilityLabel = "Welcome text"
}
