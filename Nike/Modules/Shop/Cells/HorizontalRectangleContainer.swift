//
//  NewAndFeaturedCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 11/27/24.
//

import UIKit

protocol HorizontalRectangleContainerDelegate: AnyObject {
    func didSelectProduct(_ product: Product)
}

enum HorizontalRectangleContainerDataType {
    case newThisWeek(_ model: [Product])
    
    var itemSize: CGSize {
        switch self {
        case .newThisWeek:
            return CGSize(width: 245, height: 225)
        }
    }
}

class HorizontalRectangleContainer: UITableViewCell {
    
    weak var delegate: HorizontalRectangleContainerDelegate?
    
    private var dataType: HorizontalRectangleContainerDataType?
       
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
        
        collectionView.registerCell(HorizontalRectangleCell.self)
        collectionView.registerCell(LargeSquareCollectionCell.self)
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
        titleLabel.text = nil
        dataType = nil
        collectionView.reloadData()
    }
}

//MARK: - Public
extension HorizontalRectangleContainer {
    
    func updateHeader(_ header: Header?) {
        titleLabel.text = header?.title
    }
    
    func update(dataType: HorizontalRectangleContainerDataType, sectionHeight: CGFloat) {
        self.dataType = dataType
        
        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = sectionHeight
            heightConstraint.priority = .defaultHigh
        }
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension HorizontalRectangleContainer: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataType = dataType else { return 0 }
        switch dataType {
            
        case .newThisWeek(let model):
            return model.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataType = dataType else { return UICollectionViewCell() }
        switch dataType {
            
        case .newThisWeek(let model):
            let cell = collectionView.dequeuCell(indexPath) as HorizontalRectangleCell
            let newThisWeekData = model[indexPath.item]
            cell.updateNewAndFeaturedSection(newThisWeekData)
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate
extension HorizontalRectangleContainer: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataType = dataType else { return }
        switch dataType {
        case .newThisWeek(let model):
            let selectedProduct = model[indexPath.item]
            delegate?.didSelectProduct(selectedProduct)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HorizontalRectangleContainer: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataType?.itemSize ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}


// MARK: - Layout
extension HorizontalRectangleContainer {
    
    func setupView() {
        contentView.addSubview(labelStackView)
        contentView.addSubview(collectionView)
        labelStackView.addArrangedSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            collectionView.heightAnchor.constraint(equalToConstant: 0),
            
            collectionView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}







