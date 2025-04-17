//
//  DetailVCPageControlTableViewCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 11/13/24.
//

import UIKit

final class DetailProductsContainer: UITableViewCell {
    
    private var subCategories: [SubCategoryModel] = []
    private var currentPage: Int = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerCell(DetailProductsCollectionCell.self)
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPageIndicatorTintColor = .black
        control.pageIndicatorTintColor = .gray
        return control
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
extension DetailProductsContainer {
    
    func update(_ model: [SubCategoryModel]) {
        self.subCategories = model
        pageControl.numberOfPages = model.count
        collectionView.reloadData()
        scrollToCurrentPage()
    }
    
    private func scrollToCurrentPage() {
        guard currentPage < subCategories.count else { return }
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}

//MARK: - UICollectionViewDataSource
extension DetailProductsContainer: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeuCell(indexPath) as DetailProductsCollectionCell
        
        let subCategories = subCategories[indexPath.item]
        cell.update(subCategories)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension DetailProductsContainer: UICollectionViewDelegate {}

//MARK: - UIScrollViewDelegate
extension DetailProductsContainer: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        currentPage = Int(scrollView.contentOffset.x / pageWidth)
        pageControl.currentPage = currentPage
    }
}

//MARK: - Layout
extension DetailProductsContainer {
    
    private func setupViews() {
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 500),
            
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DetailProductsContainer: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
    
