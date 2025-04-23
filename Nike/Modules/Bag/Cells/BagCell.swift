//
//  Orders.swift
//  Nike
//
//  Created by Александр Милейчик on 12/17/24.
//

import UIKit

protocol BagCellDelegate: AnyObject {
    func didRequestDeleteItem(at indexPath: IndexPath, model: SubCategoryModel)
    func didUpdatePrice(totalPrices: Double)
}

final class BagCell: UITableViewCell {
    
    weak var delegate: BagCellDelegate?
    weak var parentViewController: UIViewController?
    private var subCategoryModel: SubCategoryModel?
    var bagService = BagService()
    
    private let photoImageView = ImageView(type: .common)
    private let titleLabel = Label(type: .title)
    private let descriptionLabel = Label(type: .titleDescription)
    private let priceLabel = Label(type: .subtitle)
    private let separatorView = UIView.makeSeparator()
    
    private lazy var quantityButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(quantityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureQuantityButton(count: Double) {
        var config = UIButton.Configuration.plain()
        config.title = "Qty \(Int(count))"
        config.baseForegroundColor = .black
        config.contentInsets = .zero
        config.image = UIImage(systemName: "chevron.down")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        config.imagePlacement = .trailing
        config.imagePadding = 8
        quantityButton.configuration = config
    }
}

//MARK: - Action Handler
extension BagCell {
    
    @objc private func quantityButtonTapped() {
        
        let quantityPickerViewController = QuantityPickerViewController()
        quantityPickerViewController.delegate = self
        quantityPickerViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = quantityPickerViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        parentViewController?.present(quantityPickerViewController, animated: true)
    }
}

//MARK: - QuantitySelectionDelegate
extension BagCell: QuantitySelectionDelegate {
    
    func didSelectQuantity(_ count: Double) {
        guard let model = subCategoryModel else { return }
        configureQuantityButton(count: count)
        
        var storedProducts = bagService.fetchTopPicks()
        if let index = storedProducts.firstIndex(where: { $0.id == model.id }) {
            storedProducts[index].count = count
            bagService.save(storedProducts)
        }
        updateProductPriceLabel(price: model.price ?? 0.0, count: count)
    }
    
    private func updateProductPriceLabel(price: Double, count: Double) {
        let totalPrice = price * count
        priceLabel.text = String(format: "$%.2f", totalPrice)
        delegate?.didUpdatePrice(totalPrices: totalPrice)
    }
}

//MARK: - Public
extension BagCell {
    
    func update(_ model: SubCategoryModel) {
        self.subCategoryModel = model
        guard let price = model.price, let count = model.count else { return }
        photoImageView.image = UIImage(named: model.subCategoryImage ?? "")
        titleLabel.text = model.title
        descriptionLabel.text = model.category
        configureQuantityButton(count: count)
        updateProductPriceLabel(price: price, count: count)
    }
    
    func configureCellSeparator(indexPath: IndexPath, numberOfRowsInSection: Int) {
        separatorView.isHidden = indexPath.row == numberOfRowsInSection - 1
    }
}

//MARK: - Layout
extension BagCell {
    
    func setupViews() {
        [photoImageView, titleLabel, descriptionLabel, quantityButton, priceLabel, separatorView].forEach { contentView.addSubview($0) }
    }
    
    func setupConstraints() {
        let minHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 240)
        minHeightConstraint.priority = .defaultLow
        minHeightConstraint.isActive = true
        
        quantityButton.contentHorizontalAlignment = .left
        [quantityButton, separatorView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            descriptionLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 24),
            
            quantityButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 6),
            quantityButton.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            quantityButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            priceLabel.centerYAnchor.constraint(equalTo: quantityButton.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}



