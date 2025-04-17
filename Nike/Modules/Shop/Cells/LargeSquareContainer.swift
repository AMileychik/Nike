//
//  NearbyStoresCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 11/23/24.
//

import UIKit

protocol LargeSquareContainerDelegate: AnyObject {
    func didSelectLargeSquareCell(_ product: Product)
}

enum LargeSquareContainerDataType {
    case nearbyStoreSectionData(models: [Product])
    
    var itemSize: CGSize {
        switch self {
        case .nearbyStoreSectionData:
            return CGSize(width: 275, height: 308)
        }
    }
}

class LargeSquareContainer: UITableViewCell {
    
    weak var delegate: LargeSquareContainerDelegate?

    private var largeSquareContainerDataType: LargeSquareContainerDataType?
    
    private lazy var titleLabel = Label(type: .header)
    private let labelStackView = StackView(type: .headerStackView)

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.registerCell(LargeSquareCollectionCell.self)
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
extension LargeSquareContainer {
    @objc private func buttonTapped() {
        print("Tapped")
    }
}

//MARK: - Public
extension LargeSquareContainer {
    
    func updateHeader(_ header: Header?) {
        titleLabel.text = header?.title
    }
    
    func update(_ model: LargeSquareContainerDataType, sectionHeight: CGFloat) {
        self.largeSquareContainerDataType = model
        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = sectionHeight
            heightConstraint.priority = .defaultHigh
        }
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension LargeSquareContainer: UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataType2 = largeSquareContainerDataType else { return 0 }
        switch dataType2 {
            
        case .nearbyStoreSectionData(models: let model):
            return model.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let largeSquareContainerDataType = largeSquareContainerDataType else { return UICollectionViewCell() }
        switch largeSquareContainerDataType {
            
        case .nearbyStoreSectionData(let model):
            
            let cell = collectionView.dequeuCell(indexPath) as LargeSquareCollectionCell
            let data = model[indexPath.item]
            cell.updateNearbyStoreSection(data)
            
            return cell
        }
    }
}

//MARK: -
extension LargeSquareContainer: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataType = largeSquareContainerDataType else { return }
        switch dataType {
       
        case .nearbyStoreSectionData(let model):
            let selectedProduct = model[indexPath.item]
            delegate?.didSelectLargeSquareCell(selectedProduct)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension LargeSquareContainer: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return largeSquareContainerDataType?.itemSize ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}

//MARK: - Layout
extension LargeSquareContainer {
    
    private func setupViews() {
        contentView.addSubview(labelStackView)
        contentView.addSubview(collectionView)
        labelStackView.addArrangedSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),

            collectionView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 0)
        ])
    }
}
