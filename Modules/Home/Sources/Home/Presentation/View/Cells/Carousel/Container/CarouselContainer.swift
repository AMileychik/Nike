//
//  TopPicksCell.swift
//  Nike
//
//  Created by Александр Милейчик on 1/13/25.
//

import UIKit

import AppDomain
import DesignSystem
import AppInterface

// MARK: - Public

/// UITableViewCell containing a horizontal collection view for displaying BecauseYouLike items.
/// Generic over `Item` and `Header` types.
public final class CarouselContainer<Item: AnyItemProtocol, Header: BecauseYouLikeHeader>: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UI Components
    
    private let headerTitleLabel = Label(type: .header)
    private let headerDescriptionLabel = Label(type: .headerDescriptionLabel)
    private let headerContainerStackView = UIStackView()
    
    private var headerButton: HeaderButtonProtocol?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        registerCells(for: collectionView)
        return collectionView
    }()
    
    private func registerCells(for collectionView: UICollectionView) {
        collectionView.registerCell(CarouselCollectionCell<Item>.self)
    }
    
    // MARK: - Properties
    
    private var items: [Item] = []
    private var header: Header?
    private var itemSize: CGSize = .zero
    
    /// Closure for handling user actions in the cell
    public var onAction: ((HomeCellAction) -> Void)?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Header Configuration
    
    /// Sets a custom header button if one is not already added
    /// - Parameter button: Button conforming to `HeaderButtonProtocol`
    public func setHeaderButton(_ button: HeaderButtonProtocol) {
        guard headerButton == nil else { return }
        headerButton = button
        headerContainerStackView.addArrangedSubview(button)
        
        if let header = header {
            button.setTitle(header.buttonTitle)
        }
        
        button.onButtonTapped = { [weak self] in
            self?.onAction?(.becauseYouLikeHeader(.headerButtonTapped))
        }
    }
    
    /// Applies header data to UI elements
    /// - Parameter model: Header model conforming to `BecauseYouLikeHeader`
    public func applyHeader(_ model: Header) {
        headerTitleLabel.text = model.title
        headerDescriptionLabel.text = model.subtitle
        headerDescriptionLabel.isHidden = model.subtitle?.isEmpty ?? true
        headerButton?.setTitle(model.buttonTitle)
    }
    
    // MARK: - Configuration
    
    /// Configures the cell with a section view model
    /// - Parameter section: `BecauseYouLikeSectionViewModel` containing header, items, and itemSize
 //   public func configure(with section: BecauseYouLikeSectionViewModel<Item, Header>) {
   
    public func configure(with section: CarouselContainerSection<Item, Header>) {
        self.header = section.header
        items = section.items
        itemSize = section.itemSize
        applyHeader(section.header)
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeuCell(indexPath) as CarouselCollectionCell<Item>
        cell.update(with: items[indexPath.item])
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        onAction?(.becauseYouLikeItemSelected(item))
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        itemSize
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                                   layout collectionViewLayout: UICollectionViewLayout,
                                   insetForSectionAt section: Int) -> UIEdgeInsets {
            .init(top: 0, left: Constants.headerStackLeading, bottom: 0, right: Constants.headerStackTrailing)
        }
        
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.minimumLineSpacing
    }
}

// MARK: - Layout Setup

private extension CarouselContainer {
    
    func configureView() {
        contentView.addSubview(headerContainerStackView)
        contentView.addSubview(collectionView)
        
        headerContainerStackView.axis = .horizontal
        headerContainerStackView.alignment = .center
        headerContainerStackView.distribution = .equalSpacing
        headerContainerStackView.spacing = 12
        
        headerContainerStackView.addArrangedSubview(headerTitleLabel)
    }
    
    func configureLayout() {
        [headerContainerStackView, collectionView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            // Header container
            headerContainerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.headerStackLeading),
            headerContainerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.headerStackTrailing),
            headerContainerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.stackTop),
            
            // Collection view
            collectionView.topAnchor.constraint(equalTo: headerContainerStackView.bottomAnchor, constant: Constants.stackBottomToCollection),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.collectionViewBottom),
            collectionView.heightAnchor.constraint(equalToConstant: Constants.collectionViewHeight)
        ])
    }
}

// MARK: - Layout Constants

private enum Constants {

    // Header
    static let headerStackLeading: CGFloat = 24
    static let headerStackTrailing: CGFloat = -24
    static let stackTop: CGFloat = 36
    static let stackBottomToCollection: CGFloat = 24

    // Collection
    static let collectionViewHeight: CGFloat = 280
    static let collectionViewBottom: CGFloat = -36
    static let minimumLineSpacing: CGFloat = 12

    // Button
    static let headerButtonWidth: CGFloat = 75
}


