//
//  SizeCell.swift
//  Nike
//
//  Created by Александр Милейчик on 3/1/25.
//

import UIKit

final class SizeContainer: UITableViewCell {
    
    private var sizes: [ProductSize] = []
    
    private lazy var headerTitleLabel = Label(type: .header)
    private let headerStackView = StackView(type: .headerStackView)
    private lazy var headerButton = HeaderButton()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.registerCell(SizeCollectionViewCell.self)
        return collectionView
    }()
    
    var onHeaderButtonTapped: (() -> Void)?

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
extension SizeContainer {
    
    func updateHeader(_ model: Header) {
        headerTitleLabel.text = model.title
        headerButton.customButton.setTitle(model.buttonTitle, for: .normal)
    }
    
    func update(_ model: [ProductSize], sectionHeight: CGFloat) {
        self.sizes = model
        updateCollectionViewHeight(to: sectionHeight)
        collectionView.reloadData()
    }

    private func updateCollectionViewHeight(to height: CGFloat) {
        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = height
            heightConstraint.priority = .defaultHigh
        }
    }
    
    func setupButtonAction() {
        headerButton.onButtonTapped = { [weak self] in
            self?.onHeaderButtonTapped?()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension SizeContainer: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeuCell(indexPath) as SizeCollectionViewCell
        let data = sizes[indexPath.item]
        cell.update(data)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension SizeContainer: UICollectionViewDelegate {}

//MARK: - UICollectionViewDelegateFlowLayout
extension SizeContainer: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}

//MARK: - Layout
extension SizeContainer {
    
    private func setupViews() {
        [headerStackView, collectionView, headerButton].forEach { contentView.addSubview($0) }
        headerStackView.addArrangedSubview(headerTitleLabel)
    }
    
    private func setupConstraints() {
        headerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            headerButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            headerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            headerButton.widthAnchor.constraint(equalToConstant: 100),
            headerButton.bottomAnchor.constraint(equalTo: headerTitleLabel.bottomAnchor),
            
            collectionView.heightAnchor.constraint(equalToConstant: 0),
            
            collectionView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
