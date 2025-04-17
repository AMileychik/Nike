//
//  ClassicsSpotlightCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 1/24/25.
//

import UIKit

protocol ClassicsSpotlightCellDelegate: AnyObject {
    func didSelectClassicsSpotlight(_ product: Product)
}

class ClassicsSpotlightCell: UITableViewCell {

    weak var delegate: ClassicsSpotlightCellDelegate?

    private var data: [Product] = []
    
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
        collectionView.registerCell(RecentlyViewedCollectionCell.self)
        collectionView.registerCell(HorizontalRectangleCell.self)
        collectionView.registerCell(ClassicsSpotlightCollectionViewCell.self)
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
extension ClassicsSpotlightCell {
    
    func updateHeader(_ header: Header?) {
        titleLabel.text = header?.title
    }
    
    func update(_ model: [Product], sectionHeight: CGFloat) {
        self.data = model
        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = sectionHeight
            heightConstraint.priority = .defaultHigh
        }
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension ClassicsSpotlightCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeuCell(indexPath) as ClassicsSpotlightCollectionViewCell
        let data = data[indexPath.item]
        cell.update(data)
       
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ClassicsSpotlightCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedProduct = data[indexPath.item]
        delegate?.didSelectClassicsSpotlight(selectedProduct)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ClassicsSpotlightCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 225)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}

//MARK: - Layout
extension ClassicsSpotlightCell {
    
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
            
            collectionView.heightAnchor.constraint(equalToConstant: 0),
        ])
    }
}
