//
//  TestCell.swift
//  Nike
//
//  Created by Александр Милейчик on 11/26/24.
//

import UIKit

protocol RecentlyViewedContainerContainerDelegate: AnyObject {
    func didSelectRecentlyViewed(_ product: Product)
}

class RecentlyViewedContainer: UITableViewCell {
    
    weak var delegate: RecentlyViewedContainerContainerDelegate?
    private var recentlyViewedData: [Product] = []
    
    private lazy var headerTitleLabel = Label(type: .header)
    private let headerStackView = StackView(type: .headerStackView)
    private lazy var headerButton = HeaderButton()

    var onRemoveSection: (() -> Void)?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.registerCell(LargeSquareCollectionCell.self)
        collectionView.registerCell(RecentlyViewedCollectionCell.self)
        collectionView.registerCell(HorizontalRectangleCell.self)
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Event Handler
extension RecentlyViewedContainer {
    
    @objc private func buttonTapped() {
        onRemoveSection?()
    }
}

//MARK: - Public
extension RecentlyViewedContainer {
    
    func updateHeader(_ header: Header?) {
        headerTitleLabel.text = header?.title
        headerButton.customButton.setTitle(header?.buttonTitle, for: .normal)
    }
    
    func update(_ model: [Product], sectionHeight: CGFloat) {
        self.recentlyViewedData = model
        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = sectionHeight
            heightConstraint.priority = .defaultHigh
        }
        collectionView.reloadData()
    }
    
    func observe() {
        headerButton.onButtonTapped = { [weak self] in
            self?.onRemoveSection?()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension RecentlyViewedContainer: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentlyViewedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeuCell(indexPath) as RecentlyViewedCollectionCell
        
        let data = recentlyViewedData[indexPath.item]
        cell.updateRecentlyViewed(data)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension RecentlyViewedContainer: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}

//MARK: - UICollectionViewDelegate
extension RecentlyViewedContainer: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedProduct = recentlyViewedData[indexPath.item]
        delegate?.didSelectRecentlyViewed(selectedProduct)
    }
}

//MARK: - Layout
extension RecentlyViewedContainer {
    
    private func setupViews() {
        [headerStackView, headerButton, collectionView].forEach { contentView.addSubview($0) }
        headerStackView.addArrangedSubview(headerTitleLabel)
    }
    
    private func setupConstraints() {
        headerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            headerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            headerButton.topAnchor.constraint(equalTo: headerTitleLabel.topAnchor),
            headerButton.widthAnchor.constraint(equalToConstant: 75),
            
            collectionView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            collectionView.heightAnchor.constraint(equalToConstant: 0)
        ])
    }
}
