//
//  TopPicksCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 1/13/25.
//

import UIKit

protocol BecauseYouLikeContainerDelegate: AnyObject {
    
    func didSelectItem(model: [Product],
                       categories: Categories?,
                       header: Header?,
                       category: String,
                       subCategory: SubCategoryModel?)
}

enum BecauseYouLikeContainerDataType {
    case product(_ model: [Product])
    
    var itemSize: CGSize {
        switch self {
        case .product:
            return CGSize(width: 150, height: 280)
        }
    }
}

class BecauseYouLikeContainer: UITableViewCell {
    
    private var productsContainerDataType: BecauseYouLikeContainerDataType?
    weak var becauseYouLikeContainerDelegate: BecauseYouLikeContainerDelegate?
    
    let categories: [Categories] = []
    
    private let headerTitleLabel = Label(type: .header)
    private let headerDescriptionLabel = Label(type: .headerDescriptionLabel)
    
    private let headerStackView = StackView(type: .headerStackView)
    private let buttonStackView = StackView(type: .headerStackView)
    
    private lazy var headerButton = HeaderButton()
    
    var onHeaderButtonTapped: (() -> Void)?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.registerCell(BecauseYouLikeCollectionCell.self)
        
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

// MARK: - Public
extension BecauseYouLikeContainer {
    
    func updateHeader(_ model: Header) {
        headerTitleLabel.text = model.title
        headerDescriptionLabel.text = model.subtitleLabel
        
        headerButton.customButton.setTitle(model.buttonTitle, for: .normal)
        
        if let subtitle = model.subtitleLabel, !subtitle.isEmpty {
            if !headerStackView.arrangedSubviews.contains(headerDescriptionLabel) {
                headerStackView.addArrangedSubview(headerDescriptionLabel)
            }
            
        } else {
            headerDescriptionLabel.removeFromSuperview()
        }
    }
    
    func update(dataType: BecauseYouLikeContainerDataType) {
        self.productsContainerDataType = dataType
        collectionView.reloadData()
    }
}

// MARK: - Action Handler
extension BecauseYouLikeContainer {
    
    func setupHeaderButtonAction() {
        headerButton.onButtonTapped = { [weak self] in
            self?.onHeaderButtonTapped?()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension BecauseYouLikeContainer: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let dataType = productsContainerDataType else { return 0 }
        switch dataType {
            
        case .product(let model):
            return model.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let dataType = productsContainerDataType else { return UICollectionViewCell() }
        switch dataType {
            
        case .product(let model):
            let cell = collectionView.dequeuCell(indexPath) as BecauseYouLikeCollectionCell
            
            let topPicksData = model[indexPath.item]
            cell.update(dataType: .productModel([topPicksData]))
            
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate
extension BecauseYouLikeContainer: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataType = productsContainerDataType else { return }
        
        switch dataType {
        case .product(let model):
            let model = model[indexPath.item]
            let category = model.categoryName ?? ""
            
            let categories = model.categories?.first ?? Categories(id: nil, categoryImage: "", subCategories: [])
            let header = model.header ?? Header(title: "", subtitleLabel: "", buttonTitle: "")
            let subCategory = model.categories?.first?.subCategories?.first ?? SubCategoryModel(id: nil, subCategoryImage: "", title: "", category: "", count: nil, price: nil, isHeartFilled: nil)
            
            becauseYouLikeContainerDelegate?.didSelectItem(
                model: [model],
                categories: categories,
                header: header,
                category: category,
                subCategory: subCategory
            )
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension BecauseYouLikeContainer: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return productsContainerDataType?.itemSize ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

// MARK: - Layout
extension BecauseYouLikeContainer {
    
    private func setupViews() {
        [collectionView, headerStackView, buttonStackView].forEach { contentView.addSubview($0) }
        [headerTitleLabel, headerDescriptionLabel].forEach { headerStackView.addArrangedSubview($0) }
        buttonStackView.addArrangedSubview(headerButton)
    }
    
    private func setupConstraints() {
        [collectionView, headerButton, headerStackView, buttonStackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 280)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36),
            headerStackView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -24),
            
            buttonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            buttonStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36),
            
            headerButton.bottomAnchor.constraint(equalTo: headerTitleLabel.bottomAnchor),
            headerButton.widthAnchor.constraint(equalToConstant: 75),
            
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -36)
        ])
    }
}
