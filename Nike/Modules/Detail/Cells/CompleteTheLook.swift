//
//  CompleteTheLook.swift
//  Nike
//
//  Created by Александр Милейчик on 3/5/25.
//

import UIKit

final class CompleteTheLook: UITableViewCell {
    
    private var categories: [CompleteTheLookModel] = []
    
    private lazy var headerTitleLabel = Label(type: .header)
    private let headerStackView = StackView(type: .headerStackView)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerCell(CompleteTheLookCollectionViewCell.self)
        return collectionView
    }()
    
    var onRemoveSection: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Action Handler
extension CompleteTheLook {
    @objc private func buttonTapped() {
        onRemoveSection?()
    }
}

//MARK: - Public
extension CompleteTheLook {
    
    func updateHeader(_ header: CompleteTheLookHeader) {
        headerTitleLabel.text = header.title
    }
    
    func update(_ model: [CompleteTheLookModel], sectionHeight: CGFloat) {
        self.categories = model
        updateCollectionViewHeight(to: sectionHeight)
        collectionView.reloadData()
    }
    
    private func updateCollectionViewHeight(to height: CGFloat) {
        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = height
            heightConstraint.priority = .defaultHigh
        }
    }
}

//MARK: - UICollectionViewDataSource
extension CompleteTheLook: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeuCell(indexPath) as CompleteTheLookCollectionViewCell
        
        let data = categories[indexPath.item]
        cell.update(data)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension CompleteTheLook: UICollectionViewDelegate {}

//MARK: - UICollectionViewDelegateFlowLayout
extension CompleteTheLook: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 375)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

//MARK: - Layout
extension CompleteTheLook {
    
    private func setupViews() {
        [headerStackView, collectionView].forEach { contentView.addSubview($0) }
        headerStackView.addArrangedSubview(headerTitleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            collectionView.heightAnchor.constraint(equalToConstant: 0),
            
            collectionView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
