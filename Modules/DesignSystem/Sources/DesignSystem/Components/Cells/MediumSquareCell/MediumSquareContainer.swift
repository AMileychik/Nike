//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/6/25.
//

import UIKit
//import DesignSystem
import AppDomain
import AppCore

public protocol MediumSquareCellDelegate: AnyObject {
    func didSelectMediumSquareCell(_ product: Product)
    func didSelectMediumSquareCell2(_ product: YouMightAlsoLikeModel)
}

public enum MediumSquareContainerDataType {
    case mediumSquareCollectionViewCell(models: [Product])
    case oneMoremediumSquareCollectionViewCell(model: [YouMightAlsoLikeModel])
    
    var itemSize: CGSize {
        CGSize(width: 250, height: 364)
    }
}

public final class MediumSquareContainer: UITableViewCell {
    
    public weak var delegate: MediumSquareCellDelegate?
    public var dataType: MediumSquareContainerDataType?
    
    public lazy var headerTitleLabel = Label(type: .header)
    public let headerStackView = StackView(type: .headerStackView)
//    private lazy var headerButton = HeaderButton()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.registerCell(MediumSquareCollectionCell.self)
        return collectionView
    }()
    
    public var onHeaderButtonTapped: (() -> Void)?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    public required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Public API
extension MediumSquareContainer {
    
    public func updateHeader(_ header: Header?) {
        headerTitleLabel.text = header?.title
    }
    
    public func updateYouMightAlsoLikeHeader(_ header: YouMightAlsoLikeHeader?) {
        headerTitleLabel.text = header?.title
    }
    
    public func update(_ model: MediumSquareContainerDataType, sectionHeight: CGFloat) {
        self.dataType = model
        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = sectionHeight
            heightConstraint.priority = .defaultHigh
        }
        collectionView.reloadData()
    }
    
    public func observe() {
  //      headerButton.onButtonTapped = { [weak self] in
  //          self?.onHeaderButtonTapped?()
  //      }
    }
}

// MARK: - UICollectionViewDataSource
extension MediumSquareContainer: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataType = dataType else { return 0 }
        switch dataType {
        case .mediumSquareCollectionViewCell(let models):
            return models.count
        case .oneMoremediumSquareCollectionViewCell(let models):
            return models.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataType = dataType else { return UICollectionViewCell() }
        
        switch dataType {
        case .mediumSquareCollectionViewCell(let models):
            let cell = collectionView.dequeuCell(indexPath) as MediumSquareCollectionCell
            let product = models[indexPath.item]
            cell.updateNearbyStoreSection(product)
            return cell
            
        case .oneMoremediumSquareCollectionViewCell(let models):
            let cell = collectionView.dequeuCell(indexPath) as MediumSquareCollectionCell
            let item = models[indexPath.item]
            cell.updateYouMightAlsoLike(item)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MediumSquareContainer: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataType = dataType else { return }
        
        switch dataType {
        case .mediumSquareCollectionViewCell(let models):
            let selectedProduct = models[indexPath.item]
            delegate?.didSelectMediumSquareCell(selectedProduct)
            
        case .oneMoremediumSquareCollectionViewCell(let models):
            let selectedItem = models[indexPath.item]
            delegate?.didSelectMediumSquareCell2(selectedItem)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MediumSquareContainer: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataType?.itemSize ?? .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        6
    }
}

// MARK: - Layout Setup
private extension MediumSquareContainer {
    
//    func setupViews() {
//        [headerStackView, headerButton, collectionView].forEach { contentView.addSubview($0) }
//        headerStackView.addArrangedSubview(headerTitleLabel)
//    }
    
    public func setupViews() {
        [headerStackView, collectionView].forEach { contentView.addSubview($0) }
        headerStackView.addArrangedSubview(headerTitleLabel)
    }
    
    public func setupConstraints() {
//        headerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 64),
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            collectionView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 0),
            
//            headerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
//            headerButton.leadingAnchor.constraint(greaterThanOrEqualTo: headerStackView.trailingAnchor, constant: 16),
//            headerButton.topAnchor.constraint(equalTo: headerTitleLabel.topAnchor),
//            headerButton.widthAnchor.constraint(equalToConstant: 95)
        ])
    }
}
