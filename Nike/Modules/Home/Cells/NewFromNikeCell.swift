//
//  ListCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 10/8/24.
//

import UIKit

protocol NewFromNikeCellDelegate: AnyObject {
    func didSelectItem(model: [NewFromNikeModel])
}

class NewFromNikeCell: UITableViewCell {
    
    weak var newFromNikeCellDelegate: NewFromNikeCellDelegate?
    
    private var newFromNikeData: [NewFromNikeModel] = []
    private var rowHeights: [CGFloat] = []
    private var gradienrIndexes: [Int] = []
    
    private let headerTitleLabel = Label(type: .header)
    private let headerStackView = StackView(type: .listHeader)
    private lazy var headerButton = HeaderButton()
    
    var onHeaderButtonTapped: (() -> Void)?
    var onExploreButtonTapped: (() -> Void)?
    var onButtomTappedTapped: (() -> Void)?
    
    private var tableViewHeightConstraint: NSLayoutConstraint?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerCell(NestedCell.self)
        tableView.registerCell(VideoCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newFromNikeData.removeAll()
        rowHeights.removeAll()
        updateTableViewHeight(0)
    }
}

//MARK: - Public
extension NewFromNikeCell {
    
    func updateHeader(_ model: Header) {
        headerTitleLabel.text = model.title
        headerButton.customButton.setTitle(model.buttonTitle, for: .normal)
    }
    
    func update(_ model: [NewFromNikeModel], heights: [CGFloat], gradientIndexes: [Int]) {
        newFromNikeData = model
        rowHeights = heights
        updateTableViewHeight(heights.reduce(0, +))
        gradienrIndexes = gradientIndexes
        tableView.reloadData()
    }
    
    func updateTableViewHeight(_ height: CGFloat) {
        tableViewHeightConstraint?.constant = height
    }
}

// MARK: - Action Handler
extension NewFromNikeCell {
    func setupHeaderButtonAction() {
        headerButton.onButtonTapped = { [weak self] in
            self?.onHeaderButtonTapped?()
        }
    }
}

//MARK: - UITableViewDataSource
extension NewFromNikeCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newFromNikeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = newFromNikeData[indexPath.row]
        if let videoURLString = data.videoURL, let videoURL = Bundle.main.url(forResource: videoURLString,
                                                                              withExtension: "mp4") {
            let cell = tableView.dequeueCell(indexPath) as VideoCell
            cell.update(url: videoURL, addGradient: true, isMuted: true)
            cell.setupViews()
            cell.playVideo()
            cell.setupButtonActions()
            
            cell.onBottomButtonTapped = { [weak self] in
                self?.onButtomTappedTapped?()
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueCell(indexPath) as NestedCell
            let shouldAddGradient = gradienrIndexes.contains(indexPath.row)
            
            if let imageName = data.image,
               let logoTitle = data.logoTitle,
               let youMightAlsoLikeHeader = data.completeTheLookHeader,
               let productData = data.productData,
               let youMightAlsoLikeModel = data.completeTheLookModel {
                
                cell.updateHomeCell(with: NewFromNikeModel(videoURL: nil,
                                                           image: imageName,
                                                           logoTitle: logoTitle,
                                                           detailImage: nil,
                                                           title: nil,
                                                           description: nil,
                                                           productData: productData,
                                                           completeTheLookHeader: youMightAlsoLikeHeader,
                                                           completeTheLookModel: youMightAlsoLikeModel),
                                    addGradient: shouldAddGradient)
            }
            cell.setupButtonActions()
            
            cell.onExploreButtonTapped = { [weak self] in
                self?.onExploreButtonTapped?()
            }
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension NewFromNikeCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = newFromNikeData[indexPath.item]
        newFromNikeCellDelegate?.didSelectItem(model: [model])
    }
}

// MARK: - Layout
extension NewFromNikeCell {
    
    private func setupViews() {
        contentView.addSubview(headerStackView)
        contentView.addSubview(tableView)
        
        headerStackView.addArrangedSubview(headerTitleLabel)
        headerStackView.addArrangedSubview(headerButton)
    }
    
    func setupConstraints() {
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeightConstraint?.isActive = true
        
        headerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            headerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            headerButton.topAnchor.constraint(equalTo: headerTitleLabel.topAnchor),
            headerButton.widthAnchor.constraint(equalToConstant: 75),
            
            tableView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
