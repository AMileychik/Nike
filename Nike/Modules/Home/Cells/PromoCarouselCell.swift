//
//  PageControlCell.swift
//  Nike
//
//  Created by Александр Милейчик on 10/7/24.
//

import UIKit

protocol PromoCarouselCellDelegate: AnyObject {
    func didSelectItem(model: [Product])
}

class PromoCarouselCell: UITableViewCell {
    
    weak var promoCarouselCellDelegate: PromoCarouselCellDelegate?
    var pageControlData: [Product] = []
    
    private var indicatorsViews: [UIView] = []
    private var autoScrollTimer: Timer?
    var isAutoScrollingEnabled: Bool = true
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerCell(PromoCollectionViewCell.self)
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupIndicators()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createIndicatorView(width: CGFloat, height: CGFloat, isFirst: Bool) -> UIView {
        let indicator = UIView()
        
        indicator.backgroundColor = .gray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        let blackPart = UIView()
        blackPart.backgroundColor = .clear
        blackPart.translatesAutoresizingMaskIntoConstraints = false
        blackPart.frame = CGRect(x: 0, y: 0, width: 0, height: height)
        
        indicator.addSubview(blackPart)
        return indicator
    }
    
    private func setupIndicators() {
        let numbersOfIndicators = pageControlData.count
        let indicatorHeight: CGFloat = 2
        let indicatorWidth: CGFloat = 15
        let spacing: CGFloat = 4
        
        indicatorsViews.forEach { $0.removeFromSuperview() }
        indicatorsViews.removeAll()
        
        for index in 0..<numbersOfIndicators {
            let indicator = createIndicatorView(width: indicatorWidth, height: indicatorHeight, isFirst: index == 0)
            contentView.addSubview(indicator)
            indicatorsViews.append(indicator)
            
            let xOffset = CGFloat(index) * (spacing + indicatorWidth) - (CGFloat(numbersOfIndicators) * (spacing + indicatorWidth) - spacing) / 2
            
            NSLayoutConstraint.activate([
                indicator.widthAnchor.constraint(equalToConstant: indicatorWidth),
                indicator.heightAnchor.constraint(equalToConstant: indicatorHeight),
                indicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: xOffset),
                indicator.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -8)
            ])
        }
        
        if let firstIndicator = indicatorsViews.first {
            let blackPart = firstIndicator.subviews[0]
            blackPart.backgroundColor = .black
            blackPart.frame.size.width = indicatorWidth
        }
    }
    
    private func updateIndicatorProgress(scrollOffset: CGFloat) {
        let pageWidth = collectionView.frame.width
        let fractionalPage = scrollOffset / pageWidth
        
        for (index, indicator) in indicatorsViews.enumerated() {
            let blackPart = indicator.subviews[0]
            let indicatorWidth = indicator.frame.width
            
            if index == Int(fractionalPage) {
                let progress = fractionalPage - CGFloat(index)
                blackPart.frame.size.width = indicatorWidth * (1 - progress)
                blackPart.frame.origin.x = indicatorWidth * progress
                blackPart.backgroundColor = .black
                
            } else if index == Int(fractionalPage) + 1 {
                
                blackPart.frame.size.width = indicatorWidth * (fractionalPage - CGFloat(index) + 1)
                blackPart.frame.origin.x = 0
                blackPart.backgroundColor = .black
                
            } else {
                blackPart.frame.size.width = 0
                blackPart.backgroundColor = .clear
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if autoScrollTimer == nil && !pageControlData.isEmpty {
            startAutoScrollTimer()
        }
    }
    
    func startAutoScrollTimer() {
        guard autoScrollTimer == nil, isAutoScrollingEnabled else { return }
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
    }
    
    @objc private func scrollToNextPage() {
        let currentOffset = collectionView.contentOffset.x
        let pageWidth = collectionView.frame.width
        let nextOffset = currentOffset + pageWidth
        let maxOffset = collectionView.contentSize.width - pageWidth
        
        if nextOffset <= maxOffset {
            collectionView.setContentOffset(CGPoint(x: nextOffset, y: 0), animated: true)
        } else {
            collectionView.setContentOffset(.zero, animated: true)
        }
    }
    
    func stopAutoScrollTimer() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopAutoScrollTimer()
        pageControlData = []
        collectionView.setContentOffset(.zero, animated: false)
        collectionView.reloadData()
        indicatorsViews.forEach { $0.removeFromSuperview() }
        indicatorsViews.removeAll()
    }
}

//MARK: - Public
extension PromoCarouselCell {
    
    func update(_ model: [Product], sectionHeight: CGFloat) {
        self.pageControlData = model
        setupIndicators()
        
        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = sectionHeight
            heightConstraint.priority = .defaultHigh
        }
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension PromoCarouselCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageControlData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeuCell(indexPath) as PromoCollectionViewCell
        let data = pageControlData[indexPath.item]
        cell.updatePageControl(data)
        return cell
    }
}

// MARK: - UIScrollViewDelegate
extension PromoCarouselCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateIndicatorProgress(scrollOffset: scrollView.contentOffset.x)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PromoCarouselCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopAutoScrollTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startAutoScrollTimer()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let pageControlCell = cell as? PromoCarouselCell {
            pageControlCell.startAutoScrollTimer()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let pageControlCell = cell as? PromoCarouselCell {
            pageControlCell.stopAutoScrollTimer()
        }
    }
}

//MARK: - UICollectionViewDelegate
extension PromoCarouselCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = pageControlData[indexPath.item]
        promoCarouselCellDelegate?.didSelectItem(model: [model])
    }
}

// MARK: - Layout
private extension PromoCarouselCell {
    
    func setupViews() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 0)
        ])
    }
}

