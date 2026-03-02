//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import UIKit

public final class OnboardingViewController: UIViewController {
   
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue

        let label = UILabel()
        label.text = "ONBOARDING"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

