//
//  NewAndFeatureCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 1/24/25.
//

import UIKit

protocol NewAndFeaturedContainerDelegate: AnyObject {
    func didSelectNewAndFeatured(_ product: Product)
}

class NewAndFeaturedContainer: UITableViewCell {
    
    weak var delegate: NewAndFeaturedContainerDelegate?

    var newAndFeaturedData: [Product] = []
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
        
        collectionView.registerCell(CategoriesCollectionViewCell.self)
        collectionView.registerCell(LargeSquareCollectionCell.self)
        collectionView.registerCell(NewAndFeaturedCellCollectionCell.self)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        newAndFeaturedData.removeAll()
    }
}

//MARK: - Public
extension NewAndFeaturedContainer {
    
    func updateHeader(_ header: Header?) {
        titleLabel.text = header?.title
    }
    
    func update(_ model: [Product], sectionHeight: CGFloat) {
        newAndFeaturedData = model
      
        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = sectionHeight
            heightConstraint.priority = .defaultHigh
        }
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension NewAndFeaturedContainer: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newAndFeaturedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeuCell(indexPath) as NewAndFeaturedCellCollectionCell
        
        let data = newAndFeaturedData[indexPath.item]
        cell.updateNewAndFeaturedSection(data)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension NewAndFeaturedContainer: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 150, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}

//MARK: - UICollectionViewDelegate
extension NewAndFeaturedContainer: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = newAndFeaturedData[indexPath.item]
        delegate?.didSelectNewAndFeatured(selectedItem)
    }
}

// MARK: - Layout
extension NewAndFeaturedContainer {

    func setupView() {
        contentView.addSubview(labelStackView)
        contentView.addSubview(collectionView)
        labelStackView.addArrangedSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            collectionView.heightAnchor.constraint(equalToConstant: 0),
            
            collectionView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
