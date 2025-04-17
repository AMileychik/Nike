//
//  ComingSoonViewController.swift
//  LagomStore
//
//  Created by Александр Милейчик on 2/12/25.
//

import UIKit

final class ComingSoonViewController: UIViewController {
    
    private let messageLabel = UILabel()
    private let progressView = ProgressView(frame: .zero)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Text.ComingSoonViewController.seeYouSoon, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.0
        button.backgroundColor = UIColor.black.adjustBrightness(by: 0.1)
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressView.animateProgress(to: 0.99)
    }
}

//MARK: - Event Handler
extension ComingSoonViewController {
    @objc private func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Layout
extension ComingSoonViewController {
    
    private func setupView() {
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        messageLabel.text = Text.ComingSoonViewController.greatThingsTakeTime
        
        view.addSubview(messageLabel)
        view.addSubview(closeButton)
        view.addSubview(progressView)
    }
    
    private func setupConstraints() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            
            progressView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 36),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            progressView.heightAnchor.constraint(equalToConstant: 20),
            
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 180)
        ])
    }
}
