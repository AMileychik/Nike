//
//  PageControlCell.swift
//  Nike
//
//  Created by Александр Милейчик on 10/7/25.
//

//import UIKit
//
//import AppDomain
//
//public enum PromoCellLayout {
//    static let horizontalInset: CGFloat = 20
//    static let indicatorTopSpacing: CGFloat = 8
//    static let indicatorHeight: CGFloat = 6
//    static let indicatorBottomInset: CGFloat = 12
//
//    static let itemSpacing: CGFloat = 12
//}
//
//public final class PromoCarouselCell:
//    UITableViewCell,
//    UICollectionViewDataSource,
//    UICollectionViewDelegateFlowLayout {
//
//    // MARK: - State
//
//    private var viewData: PromoCarouselViewData?
//    private var itemHeight: CGFloat = 200
//
//    // MARK: - UI
//
//    private let indicator: IndicatorViewProtocol
//    private let collection: UICollectionView
//    private var heightConstraint: NSLayoutConstraint?
//
//    // MARK: - Callbacks
//
//    public var onAction: ((HomeCellAction) -> Void)?
//    public var onStartAutoScrollRequested: (() -> Void)?
//    public var onStopAutoScrollRequested: (() -> Void)?
//    
//    public var onScroll: ((CGFloat) -> Void)?
//
//    // MARK: - Init
//
//    public override init(style: UITableViewCell.CellStyle,
//         reuseIdentifier: String?
//    ) {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = PromoCellLayout.itemSpacing
//        layout.sectionInset = UIEdgeInsets(
//            top: 0,
//            left: PromoCellLayout.horizontalInset,
//            bottom: 0,
//            right: PromoCellLayout.horizontalInset
//        )
//        
//        self.collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        self.indicator = IndicatorView()
//
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        selectionStyle = .none
//
//        setupCollection()
//        setupViews()
//        setupConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Public
//
//    public func configure(
//        with viewData: PromoCarouselViewData,
//        itemHeight: CGFloat
//    ) {
//        self.viewData = viewData
//        self.itemHeight = itemHeight
//
//        heightConstraint?.constant = itemHeight
//
//        collection.reloadData()
//
//        indicator.configure(pagesCount: viewData.pages.count)
//        indicator.setProgress(0)
//    }
//
//    public func updateIndicator(fractionalPage: CGFloat) {
//        indicator.setProgress(fractionalPage)
//    }
//
//    // MARK: - Setup
//
//    private func setupCollection() {
//        collection.registerCell(PromoCollectionViewCell.self)
//        collection.showsHorizontalScrollIndicator = false
//        collection.backgroundColor = .clear
//        collection.decelerationRate = .fast
//        collection.dataSource = self
//        collection.delegate = self
//        
//        collection.isUserInteractionEnabled = true
//        collection.isScrollEnabled = true
//    }
//
//    private func setupViews() {
//        contentView.addSubview(collection)
//        contentView.addSubview(indicator)
//    }
//
//    private func setupConstraints() {
//        collection.translatesAutoresizingMaskIntoConstraints = false
//        indicator.translatesAutoresizingMaskIntoConstraints = false
//
//        heightConstraint = collection.heightAnchor.constraint(equalToConstant: itemHeight)
//        heightConstraint?.isActive = true
//
//        NSLayoutConstraint.activate([
//            collection.topAnchor.constraint(equalTo: contentView.topAnchor),
//            collection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            collection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//
//            indicator.topAnchor.constraint(
//                equalTo: collection.bottomAnchor,
//                constant: PromoCellLayout.indicatorTopSpacing
//            ),
//            indicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            indicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            indicator.heightAnchor.constraint(equalToConstant: PromoCellLayout.indicatorHeight),
//            indicator.bottomAnchor.constraint(
//                equalTo: contentView.bottomAnchor,
//                constant: -PromoCellLayout.indicatorBottomInset
//            )
//        ])
//    }
//
//    public override func prepareForReuse() {
//        super.prepareForReuse()
//        viewData = nil
//        collection.setContentOffset(.zero, animated: false)
//    }
//
//    // MARK: - Collection
//
//    public func collectionView(
//        _ collectionView: UICollectionView,
//        numberOfItemsInSection section: Int
//    ) -> Int {
//        viewData?.pages.count ?? 0
//    }
//
//    public func collectionView(
//        _ collectionView: UICollectionView,
//        cellForItemAt indexPath: IndexPath
//    ) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeuCell(indexPath) as PromoCollectionViewCell
//
//        if let page = viewData?.pages[indexPath.item] {
//            cell.updatePageControl(page)
//        }
//        return cell
//    }
//
//    public func collectionView(
//        _ collectionView: UICollectionView,
//        didSelectItemAt indexPath: IndexPath
//    ) {
//        guard let page = viewData?.pages[indexPath.item] else { return }
//        onAction?(.promo(.didTap(page: page)))
//    }
//
//    public func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: IndexPath
//    ) -> CGSize {
//
//        let width = collectionView.bounds.width - PromoCellLayout.horizontalInset * 2
//        return CGSize(width: width, height: itemHeight)
//    }
//
//        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            let cellWidth = collection.bounds.width - 40
//            let fractional = scrollView.contentOffset.x / cellWidth
//            indicator.setProgress(fractional)
//            onScroll?(fractional)
//        }
//    
//    public func scrollToPage(_ index: Int, animated: Bool = true) {
//        guard let viewData = viewData, viewData.pages.count > 0 else { return }
//        
//        let width = collection.bounds.width - PromoCellLayout.horizontalInset * 2
//        let offsetX = CGFloat(index) * (width + PromoCellLayout.itemSpacing)
//        collection.setContentOffset(CGPoint(x: offsetX, y: 0), animated: animated)
//        
//        indicator.setProgress(CGFloat(index))
//    }
//    
//    public func scrollViewWillEndDragging(
//        _ scrollView: UIScrollView,
//        withVelocity velocity: CGPoint,
//        targetContentOffset: UnsafeMutablePointer<CGPoint>
//    ) {
//        guard let viewData = viewData else { return }
//
//        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidthIncludingSpacing = collection.bounds.width - PromoCellLayout.horizontalInset*2 + layout.minimumLineSpacing
//
//        var index = round(targetContentOffset.pointee.x / cellWidthIncludingSpacing)
//        index = max(0, min(index, CGFloat(viewData.pages.count - 1)))
//
//        targetContentOffset.pointee.x = index * cellWidthIncludingSpacing
//
//        onScroll?(index)
//    }
//}
//
//extension PromoCarouselCell: LifecycleAwareCell {
//    public func willDisplay() {
//     //   print("PromoCarouselCell willDisplay — старт автоскролла")
//        onStartAutoScrollRequested?()
//    }
//
//    public func didEndDisplaying() {
//      //  print("PromoCarouselCell didEndDisplaying — стоп автоскролла")
//        onStopAutoScrollRequested?()
//    }
//}







import UIKit

public protocol CarouselScrollAnimating: AnyObject {
    func scroll(
        scrollView: UIScrollView,
        to offsetX: CGFloat,
        duration: TimeInterval,
        onProgress: @escaping (CGFloat) -> Void
    )
}

public final class CarouselScrollAnimator: CarouselScrollAnimating {
    
    private var displayLink: CADisplayLink?
    private var animation: Animation?
    
    public init() {}
    
    public func scroll(
        scrollView: UIScrollView,
        to offsetX: CGFloat,
        duration: TimeInterval,
        onProgress: @escaping (CGFloat) -> Void
    ) {
        stop()
        
        animation = Animation(
            scrollView: scrollView,
            startOffset: scrollView.contentOffset.x,
            targetOffset: offsetX,
            duration: duration,
            startTime: CACurrentMediaTime(),
            onProgress: onProgress
        )
        
        let link = CADisplayLink(target: self, selector: #selector(update))
        link.add(to: .main, forMode: .common)
        displayLink = link
    }
    
    private func stop() {
        displayLink?.invalidate()
        displayLink = nil
        animation = nil
    }
    
    @objc
    private func update() {
        guard let animation else { return }
        
        let elapsed = CACurrentMediaTime() - animation.startTime
        let progress = min(elapsed / animation.duration, 1)
        let eased = Self.easeInOut(progress)
        
        let offset =
            animation.startOffset +
            (animation.targetOffset - animation.startOffset) * CGFloat(eased)
        
        animation.scrollView.contentOffset.x = offset
        animation.onProgress(offset)
        
        if progress >= 1 {
            stop()
        }
    }
}

// MARK: - Models

private struct Animation {
    weak var scrollView: UIScrollView!
    let startOffset: CGFloat
    let targetOffset: CGFloat
    let duration: TimeInterval
    let startTime: CFTimeInterval
    let onProgress: (CGFloat) -> Void
}

// MARK: - Easing

private extension CarouselScrollAnimator {
    static func easeInOut(_ t: Double) -> Double {
        t < 0.5 ? 2 * t * t : 1 - pow(-2 * t + 2, 2) / 2
    }
}


import UIKit

import AppDomain

public final class PromoCarouselCell: UITableViewCell {
    
    // MARK: - State
    
    private var viewData: PromoCarouselViewData?
    private var itemHeight: CGFloat = PromoCellLayout.itemHeight
    
    // MARK: - UI
    
    private let collection: UICollectionView
    private let indicator: IndicatorViewProtocol
    private let scrollAnimator: CarouselScrollAnimating
    
    private var heightConstraint: NSLayoutConstraint?
    
    // MARK: - Callbacks
    
    public var onAction: ((HomeCellAction) -> Void)?
    public var onStartAutoScrollRequested: (() -> Void)?
    public var onStopAutoScrollRequested: (() -> Void)?
    public var onScroll: ((CGFloat) -> Void)?
    
    // MARK: - Init
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: Self.createLayout()
        )
        indicator = IndicatorView()
        scrollAnimator = CarouselScrollAnimator()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupCollection()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public
    
    public func configure(
        with viewData: PromoCarouselViewData,
        itemHeight: CGFloat
    ) {
        self.viewData = viewData
        self.itemHeight = itemHeight
        
        heightConstraint?.constant = itemHeight
        collection.reloadData()
        
        indicator.configure(pagesCount: viewData.pages.count)
        indicator.setProgress(0)
    }
    
    public func scrollToPage(
        _ index: Int,
        duration: TimeInterval = 1.0
    ) {
        guard let viewData, !viewData.pages.isEmpty else { return }
        
        let width = collection.bounds.width - PromoCellLayout.horizontalInset * 2
        let spacing = PromoCellLayout.itemSpacing
        let offsetX = CGFloat(index) * (width + spacing)
        
        scrollAnimator.scroll(
            scrollView: collection,
            to: offsetX,
            duration: duration
        ) { [weak self] currentOffset in
            guard let self else { return }
            let fractional = currentOffset / width
            indicator.setProgress(fractional)
            onScroll?(fractional)
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        viewData = nil
        collection.setContentOffset(.zero, animated: false)
    }
    
    // MARK: - Setup
    
    private static func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = PromoCellLayout.itemSpacing
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: PromoCellLayout.horizontalInset,
            bottom: 0,
            right: PromoCellLayout.horizontalInset
        )
        return layout
    }
    
    private func setupCollection() {
        collection.registerCell(PromoCollectionViewCell.self)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.decelerationRate = .normal
        collection.dataSource = self
        collection.delegate = self
    }
}

// MARK: - UICollectionViewDataSource

extension PromoCarouselCell: UICollectionViewDataSource {
    
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewData?.pages.count ?? 0
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: PromoCollectionViewCell = collectionView.dequeuCell(indexPath)
        
        if let page = viewData?.pages[indexPath.item] {
            cell.configure(with: page)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PromoCarouselCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let page = viewData?.pages[indexPath.item] else { return }
        onAction?(.promo(.didTap(page: page)))
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width - PromoCellLayout.horizontalInset * 2
        return CGSize(width: width, height: itemHeight)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = collection.bounds.width - PromoCellLayout.horizontalInset * 2
        let fractional = scrollView.contentOffset.x / width
        indicator.setProgress(fractional)
        onScroll?(fractional)
    }
}

// MARK: - LifecycleAwareCell

extension PromoCarouselCell: LifecycleAwareCell {
    
    public func willDisplay() {
        onStartAutoScrollRequested?()
    }
    
    public func didEndDisplaying() {
        onStopAutoScrollRequested?()
    }
}

// MARK: - Layout

private extension PromoCarouselCell {
    
    func setupViews() {
        contentView.addSubview(collection)
        contentView.addSubview(indicator)
    }
    
    func setupConstraints() {
        collection.translatesAutoresizingMaskIntoConstraints = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        heightConstraint = collection.heightAnchor
            .constraint(equalToConstant: itemHeight)
        heightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: contentView.topAnchor),
            collection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            indicator.topAnchor.constraint(
                equalTo: collection.bottomAnchor,
                constant: PromoCellLayout.indicatorTopSpacing
            ),
            indicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            indicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            indicator.heightAnchor.constraint(
                equalToConstant: PromoCellLayout.indicatorHeight
            ),
            indicator.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -PromoCellLayout.indicatorBottomInset
            )
        ])
    }
}

public enum PromoCellLayout {
    static let horizontalInset: CGFloat = 20
    static let indicatorTopSpacing: CGFloat = 8
    static let indicatorHeight: CGFloat = 6
    static let indicatorBottomInset: CGFloat = 12
    static let itemSpacing: CGFloat = 12
    static let itemHeight: CGFloat = 200
}


//import UIKit
//
//import AppDomain
//
//public enum PromoCellLayout {
//    static let horizontalInset: CGFloat = 20
//    static let indicatorTopSpacing: CGFloat = 8
//    static let indicatorHeight: CGFloat = 6
//    static let indicatorBottomInset: CGFloat = 12
//    static let itemSpacing: CGFloat = 12
//    
//    static let itemHeight: CGFloat = 200
//}
//
//public final class PromoCarouselCell: UITableViewCell {
//    
//    // MARK: - State
//    private var viewData: PromoCarouselViewData?
//    private var itemHeight: CGFloat = PromoCellLayout.itemHeight
//    
//    // MARK: - UI
//    private let collection: UICollectionView
//    private let indicator: IndicatorViewProtocol
//    private var heightConstraint: NSLayoutConstraint?
//    
//    // MARK: - Callbacks
//    public var onAction: ((HomeCellAction) -> Void)?
//    public var onStartAutoScrollRequested: (() -> Void)?
//    public var onStopAutoScrollRequested: (() -> Void)?
//    public var onScroll: ((CGFloat) -> Void)?
//    
//    // MARK: - Init
//    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        collection = UICollectionView(frame: .zero, collectionViewLayout: PromoCarouselCell.createLayout())
//        indicator = IndicatorView()
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        selectionStyle = .none
//        setupCollection()
//        setupViews()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Public
//    public func configure(with viewData: PromoCarouselViewData, itemHeight: CGFloat) {
//        self.viewData = viewData
//        self.itemHeight = itemHeight
//        heightConstraint?.constant = itemHeight
//        collection.reloadData()
//        indicator.configure(pagesCount: viewData.pages.count)
//        indicator.setProgress(0)
//    }
//    
//    public func updateIndicator(fractionalPage: CGFloat) {
//        indicator.setProgress(fractionalPage)
//    }
//    
////    public func scrollToPage(_ index: Int, animated: Bool = true) {
////        guard let viewData = viewData, !viewData.pages.isEmpty else { return }
////        let width = collection.bounds.width - PromoCellLayout.horizontalInset * 2
////        let offsetX = CGFloat(index) * (width + PromoCellLayout.itemSpacing)
////        collection.setContentOffset(CGPoint(x: offsetX, y: 0), animated: animated)
////        indicator.setProgress(CGFloat(index))
////    }
//    
//    public func scrollToPage(_ index: Int, duration: TimeInterval = 1.0) {
//        guard let viewData = viewData, !viewData.pages.isEmpty else { return }
//        
//        let width = collection.bounds.width - PromoCellLayout.horizontalInset * 2
//        let spacing = PromoCellLayout.itemSpacing
//        let targetOffsetX = CGFloat(index) * (width + spacing)
//        
//        let startOffsetX = collection.contentOffset.x
//        let distance = targetOffsetX - startOffsetX
//        
//        let animationStartTime = CACurrentMediaTime()
//        
//        let displayLink = CADisplayLink(target: self, selector: #selector(updateScroll))
//        displayLink.add(to: .main, forMode: .common)
//        
//        self.scrollAnimationData = (startOffsetX, distance, animationStartTime, duration, displayLink)
//    }
//
//    // MARK: - Animation Update
//
//    private var scrollAnimationData: (start: CGFloat, distance: CGFloat, startTime: CFTimeInterval, duration: TimeInterval, displayLink: CADisplayLink)?
//
//    @objc private func updateScroll() {
//        guard let data = scrollAnimationData else { return }
//        
//        let elapsed = CACurrentMediaTime() - data.startTime
//        let progress = min(elapsed / data.duration, 1.0)
//        let easedProgress = UIView.easeInOut(progress)
//        
//        let currentOffset = data.start + data.distance * CGFloat(easedProgress)
//        collection.contentOffset.x = currentOffset
//        
//        let fractionalPage = currentOffset / (collection.bounds.width - PromoCellLayout.horizontalInset * 2)
//        indicator.setProgress(fractionalPage)
//        
//        if progress >= 1 {
//            data.displayLink.invalidate()
//            scrollAnimationData = nil
//        }
//    }
//
//
//    
//    
//    
//    
//    
//    
//    public override func prepareForReuse() {
//        super.prepareForReuse()
//        viewData = nil
//        collection.setContentOffset(.zero, animated: false)
//    }
//    
//    // MARK: - Setup
//    private static func createLayout() -> UICollectionViewFlowLayout {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = PromoCellLayout.itemSpacing
//        layout.sectionInset = UIEdgeInsets(
//            top: 0,
//            left: PromoCellLayout.horizontalInset,
//            bottom: 0,
//            right: PromoCellLayout.horizontalInset
//        )
//        return layout
//    }
//    
//    private func setupCollection() {
//        collection.registerCell(PromoCollectionViewCell.self)
//        collection.showsHorizontalScrollIndicator = false
//        collection.backgroundColor = .clear
//        collection.decelerationRate = .normal
//        collection.dataSource = self
//        collection.delegate = self
//        collection.isUserInteractionEnabled = true
//        collection.isScrollEnabled = true
//    }
//    
//    private func handleScroll(_ scrollView: UIScrollView) {
//        let cellWidth = collection.bounds.width - PromoCellLayout.horizontalInset*2
//        let fractional = scrollView.contentOffset.x / cellWidth
//        indicator.setProgress(fractional)
//        onScroll?(fractional)
//    }
//}
//
//// MARK: - UICollectionViewDataSource
//
//extension PromoCarouselCell: UICollectionViewDataSource {
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        viewData?.pages.count ?? 0
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeuCell(indexPath) as PromoCollectionViewCell
//        if let page = viewData?.pages[indexPath.item] {
//            cell.configure(with: page)
//        }
//        return cell
//    }
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//
//extension PromoCarouselCell: UICollectionViewDelegateFlowLayout {
//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let page = viewData?.pages[indexPath.item] else { return }
//        onAction?(.promo(.didTap(page: page)))
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.bounds.width - PromoCellLayout.horizontalInset * 2
//        return CGSize(width: width, height: itemHeight)
//    }
//    
//    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        handleScroll(scrollView)
//    }
//    
//    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        guard let viewData = viewData else { return }
//        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidthIncludingSpacing = collection.bounds.width - PromoCellLayout.horizontalInset*2 + layout.minimumLineSpacing
//        var index = round(targetContentOffset.pointee.x / cellWidthIncludingSpacing)
//        index = max(0, min(index, CGFloat(viewData.pages.count - 1)))
//        targetContentOffset.pointee.x = index * cellWidthIncludingSpacing
//        onScroll?(index)
//    }
//}
//
//// MARK: - LifecycleAwareCell
//
//extension PromoCarouselCell: LifecycleAwareCell {
//    public func willDisplay() {
//        onStartAutoScrollRequested?()
//    }
//    
//    public func didEndDisplaying() {
//        onStopAutoScrollRequested?()
//    }
//}
//
//// MARK: - Layout
//
//extension PromoCarouselCell {
//    
//    private func setupViews() {
//        contentView.addSubview(collection)
//        contentView.addSubview(indicator)
//    }
//    
//    private func setupConstraints() {
//        collection.translatesAutoresizingMaskIntoConstraints = false
//        indicator.translatesAutoresizingMaskIntoConstraints = false
//        
//        heightConstraint = collection.heightAnchor.constraint(equalToConstant: itemHeight)
//        heightConstraint?.isActive = true
//        
//        NSLayoutConstraint.activate([
//            collection.topAnchor.constraint(equalTo: contentView.topAnchor),
//            collection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            collection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            
//            indicator.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: PromoCellLayout.indicatorTopSpacing),
//            indicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            indicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            indicator.heightAnchor.constraint(equalToConstant: PromoCellLayout.indicatorHeight),
//            indicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -PromoCellLayout.indicatorBottomInset)
//        ])
//    }
//}
//
//// MARK: - Easing Helper
//
//private extension UIView {
//    static func easeInOut(_ t: Double) -> Double {
//        return t < 0.5 ? 2*t*t : -1 + (4-2*t)*t
//    }
//}
