//
//  DetailButtons.swift
//  LagomStore
//
//  Created by Александр Милейчик on 11/12/24.
//

import UIKit
import ProgressHUD

final class DetailButtons: UITableViewCell {
    
    private var currentModel: SubCategoryModel?
    
    private let favoriteButton = UIButton()
    private let addToBagButton = UIButton()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addToBagButton, favoriteButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var onAddToBag: (([SubCategoryModel]) -> Void)?
    var onAddToFavorites: (([SubCategoryModel]) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButtonAppearance(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 24
    }
}

// MARK: - Action Handler
extension DetailButtons {
    
    private func setupActions() {
        addToBagButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self, let currentModel = self.currentModel else { return }
            self.onAddToBag?([currentModel])
            self.updateBagButtonAppearance(self.addToBagButton)
            ProgressHUD.succeed("Added to Bag")
        }), for: .touchUpInside)
        
        favoriteButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self, let currentModel = self.currentModel else { return }
            self.onAddToFavorites?([currentModel])
            self.updateFavoriteButtonAppearance(self.favoriteButton)
            ProgressHUD.succeed("Added to Favorite")
        }), for: .touchUpInside)
    }
    
    private func updateBagButtonAppearance(_ button: UIButton) {
        button.setTitle(Text.Detail.addedToBag, for: .normal)
        
        UIView.animate(withDuration: 0.3, animations: {
            button.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                button.alpha = 1.0
            }
        }
    }
    private func updateFavoriteButtonAppearance(_ button: UIButton) {
        button.setTitle(Text.Detail.favorited, for: .normal)
        
        UIView.animate(withDuration: 0.3, animations: {
            button.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                button.alpha = 1.0
            }
        }
    }
}

// MARK: - Public
extension DetailButtons {
    
    func update(_ model: DetailButtonsModel, current: SubCategoryModel?) {
        addToBagButton.setTitle(model.firstButtonTitle, for: .normal)
        favoriteButton.setTitle(model.secondButtonTitle, for: .normal)
        currentModel = current
    }
}

//MARK: - Layout
extension DetailButtons {
    
    private func setupViews() {
        contentView.addSubview(stackView)
        configureButtonAppearance(favoriteButton)
        configureButtonAppearance(addToBagButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            addToBagButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

