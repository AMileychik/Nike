//
//  WelcomeCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 9/27/24.
//

import UIKit

class WelcomeCell: UITableViewCell {
    
    private let welcomeLabel = Label(type: .screenTitle)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public
extension WelcomeCell {
    func update(_ text: String) {
        welcomeLabel.text = text
    }
}

//MARK: - Layout
extension WelcomeCell {
    
    func setupViews() {
        contentView.addSubview(welcomeLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            welcomeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            welcomeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            welcomeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
