//
//  ThankYouCell.swift
//  Nike
//
//  Created by Александр Милейчик on 10/2/24.
//

import UIKit

import DesignSystem

// MARK: - Public

/// UITableViewCell displaying a full-width thank you image.
final class ThankYouCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let photoImageView = ImageView(type: .thankYou)
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension ThankYouCell {
    
    func configure(with model: ThankYouViewData) {
        photoImageView.image = model.image
    }
}

// MARK: - View Configuration

private extension ThankYouCell {
    
    func configureView() {
        contentView.addSubview(photoImageView)
    }
}

// MARK: - Layout

private extension ThankYouCell {
    
    func configureLayout() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentView.heightAnchor.constraint(
                equalToConstant: Constants.cellHeight
            )
        ])
    }
}

// MARK: - Constants

private enum Constants {
    static let cellHeight: CGFloat = 250
}




//import UIKit
//
//import DesignSystem
//
//class ThankYouCell: UITableViewCell {
//    
//    private let photoImageView = ImageView(type: .thankYou)
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
////MARK: - Public
//extension ThankYouCell {
//    func configure(_ model: ThankYouViewData) {
//        photoImageView.image = model.image
//    }
//}
//
//
//// MARK: - Layout
//extension ThankYouCell {
//    
//    private func setupViews() {
//        contentView.addSubview(photoImageView)
//    }
//    
//    private func setupConstraints() {
//        photoImageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            
//            // 250 magic number
//            contentView.heightAnchor.constraint(equalToConstant: 250)
//        ])
//    }
//}


