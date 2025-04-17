//
//  AlwaysPopularCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 10/9/24.
//

import UIKit

class StoriesForYouCell: UITableViewCell {
    
    private var storiesForYouData: [StoriesForYou] = []
    
    private let largeImageView = ImageView(type: .alwaysPopular)
    private let smallImageView1 = ImageView(type: .alwaysPopular)
    private let smallImageView2 = ImageView(type: .alwaysPopular)
    
    private let headerTitleLabel = Label(type: .header)
    
    private let largeImageLabel1 = Label(type: .alwaysPopular)
    private let largeImageLabel2 = Label(type: .alwaysPopularBoltWeight)
    
    private let smallImage1Label1 = Label(type: .alwaysPopular)
    private let smallImage1Label2 = Label(type: .alwaysPopularBoltWeight)
    
    private let smallImage2Label1 = Label(type: .alwaysPopular)
    private let smallImage2Label2 = Label(type: .alwaysPopularBoltWeight)
    
    private lazy var headerButton = HeaderButton()
    private lazy var bottomButton = HeaderButton()

    var onHeaderButtonTapped: (() -> Void)?
    var onBottomButtonTapped: (() -> Void)?
    
    var onLargeImageTapped: (() -> Void)?
    var onSmallImage1Tapped: (() -> Void)?
    var onSmallImage2Tapped: (() -> Void)?
    var rightButtonTapped: (() -> Void)?
    var bottomButtonTapped: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        configureBottomButton()
        configureHeaderButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public
extension StoriesForYouCell {
    
    func update(_ model: StoriesForYou) {
        headerTitleLabel.text = model.title
        headerButton.customButton.setTitle(model.rightButtonTitle, for: .normal)
        
        largeImageView.image = UIImage(named: model.largeImage)
        smallImageView1.image = UIImage(named: model.smallImage1)
        smallImageView2.image = UIImage(named: model.smallImage2)
        
        largeImageLabel1.text = model.largeImageLabel1
        largeImageLabel2.text = model.largeImageLabel2
        
        smallImage1Label1.text = model.smallImage1Label1
        smallImage1Label2.text = model.smallImage1Label2
        
        smallImage2Label1.text = model.smallImage2Label1
        smallImage2Label2.text = model.smallImage2Label2
        
        bottomButton.customButton.setTitle(model.bottomButtonTitle, for: .normal)
    }
    
    private func configureBottomButton() {
        bottomButton.customButton.setTitleColor(.white, for: .normal)
        bottomButton.customButton.layer.cornerRadius = 24
        bottomButton.customButton.layer.borderColor = UIColor.gray.cgColor
        bottomButton.customButton.layer.borderWidth = 1.0
        bottomButton.customButton.backgroundColor = UIColor.black.adjustBrightness(by: 0.1)
    }
    
    private func configureHeaderButton() {
        headerButton.customButton.setTitleColor(.white, for: .normal)
        headerButton.customButton.backgroundColor = UIColor.black.adjustBrightness(by: 0.1)
    }
}

// MARK: - Action Handler
extension StoriesForYouCell {
    
    func setupHeaderButtonAction() {
        headerButton.onButtonTapped = { [weak self] in
            self?.onHeaderButtonTapped?()
        }
    }
    
    func setupBottomButtonAction() {
        bottomButton.onButtonTapped = { [weak self] in
            self?.onBottomButtonTapped?()
        }
    }
     
    func setupLargeImageTappedAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(largeImageTapped))
        largeImageView.addGestureRecognizer(tapGesture)
        largeImageView.isUserInteractionEnabled = true
    }
    
    func setupSmallImageView1Action() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(smallImageView1Tapped))
        smallImageView1.addGestureRecognizer(tapGesture)
        smallImageView1.isUserInteractionEnabled = true
    }
    
    func setupSmallImageView2Action() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(smallImageView2Tapped))
        smallImageView2.addGestureRecognizer(tapGesture)
        smallImageView2.isUserInteractionEnabled = true
    }
    
    @objc private func largeImageTapped() {
        onLargeImageTapped?()
    }
    
    @objc private func smallImageView1Tapped() {
        onSmallImage1Tapped?()
        print("smallImageView1Tapped")
    }
    
    @objc private func smallImageView2Tapped() {
        onSmallImage2Tapped?()
        print("smallImageView2Tapped")
    }
}

// MARK: - Layout
extension StoriesForYouCell {
    
    private func setupViews() {
        contentView.backgroundColor = UIColor.black.adjustBrightness(by: 0.1)
        
        headerTitleLabel.textColor = .white
        
        [largeImageView, smallImageView1, smallImageView2, headerTitleLabel, headerButton, bottomButton,
         largeImageLabel1, largeImageLabel2, smallImage1Label1, smallImage1Label2, smallImage2Label1, smallImage2Label2].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        headerButton.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            headerTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            headerButton.centerYAnchor.constraint(equalTo: headerTitleLabel.centerYAnchor),
            headerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            largeImageView.topAnchor.constraint(equalTo: headerTitleLabel.bottomAnchor, constant: 24),
            largeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            largeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            largeImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0),
            
            largeImageLabel1.topAnchor.constraint(equalTo: largeImageView.bottomAnchor, constant: 16),
            largeImageLabel1.leadingAnchor.constraint(equalTo: largeImageView.leadingAnchor),
            largeImageLabel1.trailingAnchor.constraint(equalTo: largeImageView.trailingAnchor),
            
            largeImageLabel2.topAnchor.constraint(equalTo: largeImageLabel1.bottomAnchor, constant: 8),
            largeImageLabel2.leadingAnchor.constraint(equalTo: largeImageLabel1.leadingAnchor),
            largeImageLabel2.trailingAnchor.constraint(equalTo: largeImageView.trailingAnchor),
            
            smallImageView1.topAnchor.constraint(equalTo: largeImageLabel2.bottomAnchor, constant: 20),
            smallImageView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            smallImageView1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.415),
            smallImageView1.heightAnchor.constraint(equalTo: smallImageView1.widthAnchor),
            
            smallImageView2.topAnchor.constraint(equalTo: largeImageLabel2.bottomAnchor, constant: 20),
            smallImageView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            smallImageView2.widthAnchor.constraint(equalTo: smallImageView1.widthAnchor),
            smallImageView2.heightAnchor.constraint(equalTo: smallImageView1.heightAnchor),
            
            smallImage1Label1.topAnchor.constraint(equalTo: smallImageView1.bottomAnchor, constant: 16),
            smallImage1Label1.leadingAnchor.constraint(equalTo: smallImageView1.leadingAnchor),
            smallImage1Label1.trailingAnchor.constraint(equalTo: smallImageView1.trailingAnchor),
            
            smallImage1Label2.topAnchor.constraint(equalTo: smallImage1Label1.bottomAnchor, constant: 8),
            smallImage1Label2.leadingAnchor.constraint(equalTo: smallImage1Label1.leadingAnchor),
            smallImage1Label2.trailingAnchor.constraint(equalTo: smallImageView1.trailingAnchor),
            
            smallImage2Label1.topAnchor.constraint(equalTo: smallImageView2.bottomAnchor, constant: 16),
            smallImage2Label1.leadingAnchor.constraint(equalTo: smallImageView2.leadingAnchor),
            smallImage2Label1.trailingAnchor.constraint(equalTo: smallImageView2.trailingAnchor),
            
            smallImage2Label2.topAnchor.constraint(equalTo: smallImage2Label1.bottomAnchor, constant: 8),
            smallImage2Label2.leadingAnchor.constraint(equalTo: smallImage2Label1.leadingAnchor),
            smallImage2Label2.trailingAnchor.constraint(equalTo: smallImageView2.trailingAnchor),
            
            bottomButton.topAnchor.constraint(equalTo: smallImage1Label2.bottomAnchor, constant: 24),
            bottomButton.leadingAnchor.constraint(equalTo: smallImageView1.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: smallImageView2.trailingAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: 50),
            bottomButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -48)
        ])
    }
}
