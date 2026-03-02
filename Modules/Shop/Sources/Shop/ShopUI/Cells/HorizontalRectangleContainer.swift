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
//public protocol HorizontalRectangleContainerDelegate: AnyObject {
//    func didSelectProduct(_ product: Product)
//}
//
//public enum HorizontalRectangleContainerDataType {
//    case newThisWeek(_ model: [Product])
//    
//    public var itemSize: CGSize {
//        switch self {
//        case .newThisWeek:
//            return CGSize(width: 245, height: 225)
//        }
//    }
//}
//
//public final class HorizontalRectangleContainer: UITableViewCell {
//    
//    public weak var delegate: HorizontalRectangleContainerDelegate?
//    private var dataType: HorizontalRectangleContainerDataType?
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
//        collectionView.registerCell(HorizontalRectangleCell.self)
//        collectionView.registerCell(LargeSquareCollectionCell.self)
//        return collectionView
//    }()
//    
//    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupView()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    public override func prepareForReuse() {
//        super.prepareForReuse()
//        titleLabel.text = nil
//        dataType = nil
//        collectionView.reloadData()
//    }
//}
//
//// MARK: - Public
//public extension HorizontalRectangleContainer {
//    
//    func updateHeader(_ header: Header?) {
//        titleLabel.text = header?.title
//    }
//    
//    func update(dataType: HorizontalRectangleContainerDataType, sectionHeight: CGFloat) {
//        self.dataType = dataType
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
//extension HorizontalRectangleContainer: UICollectionViewDataSource {
//    
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard let dataType = dataType else { return 0 }
//        switch dataType {
//        case .newThisWeek(let model):
//            return model.count
//        }
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let dataType = dataType else { return UICollectionViewCell() }
//        switch dataType {
//        case .newThisWeek(let model):
//            let cell = collectionView.dequeuCell(indexPath) as HorizontalRectangleCell
//            let product = model[indexPath.item]
//            cell.updateNewAndFeaturedSection(product)
//            return cell
//        }
//    }
//}
//
//// MARK: - UICollectionViewDelegate
//extension HorizontalRectangleContainer: UICollectionViewDelegate {
//    
//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let dataType = dataType else { return }
//        switch dataType {
//        case .newThisWeek(let model):
//            let selectedProduct = model[indexPath.item]
//            delegate?.didSelectProduct(selectedProduct)
//        }
//    }
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//extension HorizontalRectangleContainer: UICollectionViewDelegateFlowLayout {
//    
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return dataType?.itemSize ?? .zero
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
//private extension HorizontalRectangleContainer {
//    
//    func setupView() {
//        contentView.addSubview(labelStackView)
//        contentView.addSubview(collectionView)
//        labelStackView.addArrangedSubview(titleLabel)
//    }
//    
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
//            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
//            
//            collectionView.heightAnchor.constraint(equalToConstant: 0),
//            collectionView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 24),
//            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
//        ])
//    }
//}
