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
//public protocol ClassicsSpotlightCellDelegate: AnyObject {
//    func didSelectClassicsSpotlight(_ product: Product)
//}
//
//public final class ClassicsSpotlightCell: UITableViewCell {
//
//    public weak var delegate: ClassicsSpotlightCellDelegate?
//    private var data: [Product] = []
//    
//    private lazy var titleLabel = Label(type: .header)
//    private let labelStackView = StackView(type: .headerStackView)
//
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.delegate = self
//        cv.dataSource = self
//        cv.showsHorizontalScrollIndicator = false
//        
//        cv.registerCell(LargeSquareCollectionCell.self)
//        cv.registerCell(RecentlyViewedCollectionCell.self)
//        cv.registerCell(HorizontalRectangleCell.self)
//        cv.registerCell(ClassicsSpotlightCollectionViewCell.self)
//        return cv
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
//public extension ClassicsSpotlightCell {
//    
//    func updateHeader(_ header: Header?) {
//        titleLabel.text = header?.title
//    }
//    
//    func update(_ model: [Product], sectionHeight: CGFloat) {
//        self.data = model
//        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
//            heightConstraint.constant = sectionHeight
//            heightConstraint.priority = .defaultHigh
//        }
//        collectionView.reloadData()
//    }
//}
//
//// MARK: - UICollectionViewDataSource
//extension ClassicsSpotlightCell: UICollectionViewDataSource {
//    
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return data.count
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeuCell(indexPath) as ClassicsSpotlightCollectionViewCell
//        let product = data[indexPath.item]
//        cell.update(product)
//        return cell
//    }
//}
//
//// MARK: - UICollectionViewDelegate
//extension ClassicsSpotlightCell: UICollectionViewDelegate {
//    
//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedProduct = data[indexPath.item]
//        delegate?.didSelectClassicsSpotlight(selectedProduct)
//    }
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//extension ClassicsSpotlightCell: UICollectionViewDelegateFlowLayout {
//    
//    public func collectionView(_ collectionView: UICollectionView,
//                               layout collectionViewLayout: UICollectionViewLayout,
//                               sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: 150, height: 225)
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView,
//                               layout collectionViewLayout: UICollectionViewLayout,
//                               insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView,
//                               layout collectionViewLayout: UICollectionViewLayout,
//                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        6
//    }
//}
//
//// MARK: - Layout
//private extension ClassicsSpotlightCell {
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
//            
//            collectionView.heightAnchor.constraint(equalToConstant: 0)
//        ])
//    }
//}
