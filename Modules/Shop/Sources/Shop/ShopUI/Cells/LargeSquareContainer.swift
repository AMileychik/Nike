//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/6/25.
//

//import UIKit
//import AppDomain
//import DesignSystem
//import AppCore
//
//public protocol LargeSquareContainerDelegate: AnyObject {
//    func didSelectLargeSquareCell(_ product: Product)
//}
//
//public enum LargeSquareContainerDataType {
//    case nearbyStoreSectionData(models: [Product])
//    
//    public var itemSize: CGSize {
//        switch self {
//        case .nearbyStoreSectionData:
//            return CGSize(width: 275, height: 308)
//        }
//    }
//}
//
//public final class LargeSquareContainer: UITableViewCell {
//    
//    public weak var delegate: LargeSquareContainerDelegate?
//    private var largeSquareContainerDataType: LargeSquareContainerDataType?
//    
//    private lazy var titleLabel = Label(type: .header)
//    private let labelStackView = StackView(type: .headerStackView)
//    
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.showsHorizontalScrollIndicator = false
//        
//        collectionView.registerCell(LargeSquareCollectionCell.self)
//        return collectionView
//    }()
//    
//    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
//// MARK: - Public
//public extension LargeSquareContainer {
//    
//    func updateHeader(_ header: Header?) {
//        titleLabel.text = header?.title
//    }
//    
//    func update(_ model: LargeSquareContainerDataType, sectionHeight: CGFloat) {
//        self.largeSquareContainerDataType = model
//        
//        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
//            heightConstraint.constant = sectionHeight
//            heightConstraint.priority = .defaultHigh
//        }
//        collectionView.reloadData()
//    }
//}
//
//// MARK: - UICollectionViewDataSource
//extension LargeSquareContainer: UICollectionViewDataSource {
//    
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard let dataType2 = largeSquareContainerDataType else { return 0 }
//        switch dataType2 {
//        case .nearbyStoreSectionData(models: let model):
//            return model.count
//        }
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let largeSquareContainerDataType = largeSquareContainerDataType else { return UICollectionViewCell() }
//        switch largeSquareContainerDataType {
//        case .nearbyStoreSectionData(let model):
//            let cell = collectionView.dequeuCell(indexPath) as LargeSquareCollectionCell
//            let data = model[indexPath.item]
//            cell.updateNearbyStoreSection(data)
//            return cell
//        }
//    }
//}
//
//// MARK: - UICollectionViewDelegate
//extension LargeSquareContainer: UICollectionViewDelegate {
//    
//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let dataType = largeSquareContainerDataType else { return }
//        switch dataType {
//        case .nearbyStoreSectionData(let model):
//            let selectedProduct = model[indexPath.item]
//            delegate?.didSelectLargeSquareCell(selectedProduct)
//        }
//    }
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//extension LargeSquareContainer: UICollectionViewDelegateFlowLayout {
//    
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return largeSquareContainerDataType?.itemSize ?? .zero
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 6
//    }
//}
//
//// MARK: - Layout
//private extension LargeSquareContainer {
//    
//    func setupViews() {
//        contentView.addSubview(labelStackView)
//        contentView.addSubview(collectionView)
//        labelStackView.addArrangedSubview(titleLabel)
//    }
//    
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
//            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
//            
//            collectionView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 24),
//            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            collectionView.heightAnchor.constraint(equalToConstant: 0)
//        ])
//    }
//}
