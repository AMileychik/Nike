//
//  ComingSoonViewController.swift
//
//
//  Created by Александр Милейчик on 6/24/25.
//

import UIKit
import SnapKit
import AppCore
import DesignSystem


public final class ComingSoonViewController: UIViewController {
    
    private let messageLabel = UILabel()
    private let progressView = ProgressView(frame: .zero)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Text.ComingSoonViewControllerText.seeYouSoon, for: .normal)
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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressView.animateProgress(to: 0.99)
    }
}

//MARK: - Event Handler
private extension ComingSoonViewController {
    @objc func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Layout
private extension ComingSoonViewController {
    
    func setupView() {
        [messageLabel, closeButton, progressView].forEach { view.addSubview($0) }
        
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        messageLabel.text = Text.ComingSoonViewControllerText.greatThingsTakeTime
    }
    
    func setupConstraints() {
        [messageLabel, closeButton, progressView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().inset(60)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(36)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(20)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            make.height.equalTo(50)
            make.width.greaterThanOrEqualTo(180)
        }
    }
}
