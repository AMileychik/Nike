//
//  MediumSquareCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 2/27/25.
//

import UIKit

protocol MediumSquareCellDelegate: AnyObject {
    func didSelectMediumSquareCell(_ product: Product)
    func didSelectMediumSquareCell2(_ product: YouMightAlsoLikeModel)
}

enum MediumSquareContainerDataType {
    case mediumSquareCollectionViewCell(models: [Product])
    case oneMoremediumSquareCollectionViewCell(model: [YouMightAlsoLikeModel])
    
    var itemSize: CGSize {
        switch self {
       
        case .mediumSquareCollectionViewCell:
            return CGSize(width: 250, height: 364)
            
        case .oneMoremediumSquareCollectionViewCell:
            return CGSize(width: 250, height: 364)
        }
    }
}

class MediumSquareContainer: UITableViewCell {
    
    private var mediumSquareContainerDataType: MediumSquareContainerDataType?
    
    weak var delegate: MediumSquareCellDelegate?
    
    private var dataType: MediumSquareContainerDataType?


    private lazy var headerTitleLabel = Label(type: .header)
    private let headerStackView = StackView(type: .headerStackView)
    private lazy var headerButton = HeaderButton()
    
    var onHeaderButtonTapped: (() -> Void)?
    
    private lazy var collectionView: UICollectionView = {
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
extension MediumSquareContainer {
    
    func updateHeader(_ header: Header?) {
        headerTitleLabel.text = header?.title
    }
    
    func updateYouMightAlsoLikeHeader(_ header: YouMightAlsoLikeHeader?) {
        headerTitleLabel.text = header?.title
    }
    
    func update(_ model: MediumSquareContainerDataType, sectionHeight: CGFloat) {
        self.mediumSquareContainerDataType = model
        self.dataType = model
        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = sectionHeight
            heightConstraint.priority = .defaultHigh
        }
        collectionView.reloadData()
    }
    
    func observe() {
        headerButton.onButtonTapped = { [weak self] in
            self?.onHeaderButtonTapped?()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension MediumSquareContainer: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let mediumSquareContainerDataType = mediumSquareContainerDataType else { return 0 }
        switch mediumSquareContainerDataType {
            
        case .mediumSquareCollectionViewCell(models: let model):
            return model.count
        
        case .oneMoremediumSquareCollectionViewCell(model: let model):
            return model.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let mediumSquareContainerDataType = mediumSquareContainerDataType else { return UICollectionViewCell() }
        switch mediumSquareContainerDataType {
            
        case .mediumSquareCollectionViewCell(models: let model):
            let cell = collectionView.dequeuCell(indexPath) as MediumSquareCollectionCell
            let data = model[indexPath.item]
            cell.updateNearbyStoreSection(data)
            return cell
       
        case .oneMoremediumSquareCollectionViewCell(model: let model):
            let cell = collectionView.dequeuCell(indexPath) as MediumSquareCollectionCell
            let data = model[indexPath.item]
            cell.updateYouMightAlsoLike(data)
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate
extension MediumSquareContainer: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataType = dataType else { return }
        switch dataType {
        case .mediumSquareCollectionViewCell(let model):
            let selectedProduct = model[indexPath.item]
            delegate?.didSelectMediumSquareCell(selectedProduct)
    
        case .oneMoremediumSquareCollectionViewCell(let model):
            let selectedProduct = model[indexPath.item]
            delegate?.didSelectMediumSquareCell2(selectedProduct)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MediumSquareContainer: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return mediumSquareContainerDataType?.itemSize ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}

//MARK: - Layout
extension MediumSquareContainer {
    
    private func setupViews() {
        [headerStackView, headerButton, collectionView].forEach { contentView.addSubview($0) }
        headerStackView.addArrangedSubview(headerTitleLabel)
    }
    
    private func setupConstraints() {
        headerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 64),
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            collectionView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 0),
            
            headerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            headerButton.leadingAnchor.constraint(greaterThanOrEqualTo: headerStackView.trailingAnchor, constant: 16),
            headerButton.topAnchor.constraint(equalTo: headerTitleLabel.topAnchor),
            headerButton.widthAnchor.constraint(equalToConstant: 95)
        ])
    }
}

