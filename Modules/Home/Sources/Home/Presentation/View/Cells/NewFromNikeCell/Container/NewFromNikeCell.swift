//
//  ListCell.swift
//  Nike
//
//  Created by Александр Милейчик on 10/8/24.
//

import UIKit

import AppDomain
import DesignSystem
import AppInterface

// MARK: - Public

final class NewFromNikeCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let headerTitleLabel = Label(type: .header)
    private let headerStackView = StackView(type: .listHeader)
    private lazy var headerButton = HeaderButton()
    
    /// Non-scrollable table view used to render heterogeneous content inside the cell.
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        return tableView
    }()
    
    // MARK: - Data
    
    private var rows: [NewFromNikeRowProps] = []
    
    // MARK: - Layout
    
    private var tableViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Helpers
    
    private let lifecycleRouter: CellLifecycleRouting = DefaultCellLifecycleRouter()
    var onAction: ((HomeCellAction) -> Void)?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
        configureActions()
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateTableViewHeight(0)
    }
}

// MARK: - Public Methods

extension NewFromNikeCell {
    
    func update(_ viewData: NewFromNikeSectionViewData) {
        updateHeader(viewData.header)
        rows = viewData.rows
        updateTableViewHeight(rows.map(\.height).reduce(0, +))
        tableView.reloadData()
    }
}

// MARK: - TableView Height

private extension NewFromNikeCell {
    func updateTableViewHeight(_ height: CGFloat) {
        tableViewHeightConstraint?.constant = height
    }
}

// MARK: - Header

private extension NewFromNikeCell {
    
    func updateHeader(_ model: Header) {
        headerTitleLabel.text = model.title
        headerButton.customButton.setTitle(model.buttonTitle, for: .normal)
    }
}

// MARK: - Actions

private extension NewFromNikeCell {
    
    func configureActions() {
        headerButton.onButtonTapped = { [weak self] in
            self?.onAction?(.newFromNike(.headerButton))
        }
    }
    
    func selectProduct(_ row: NewFromNikeRowProps) {
        onAction?(.newFromNike(.productSelected(row)))
    }
}

// MARK: - Cell Configuration

private extension NewFromNikeCell {
    
    func configureVideoCell(
        _ cell: VideoCell,
        props: NewFromNikeRowProps.VideoProps,
        addGradient: Bool
    ) {
        cell.update(props: props, addGradient: addGradient, isMuted: true)
        cell.onBottomButtonTapped = { [weak self] in
            self?.onAction?(.newFromNike(.videoBottomButton))
        }
    }
    
    func configureProductCell(
        _ cell: NestedCell,
        for row: NewFromNikeRowProps
    ) {
        guard case .product(let props) = row.content else { return }
        
        cell.updateHomeCell(with: props, addGradient: row.addGradient)
        cell.onExploreButtonTapped = { [weak self] in
            self?.selectProduct(row)
        }
    }
    
    func makeCell(for row: NewFromNikeRowProps, at indexPath: IndexPath) -> UITableViewCell {
        switch row.content {
        case .video(let props):
            let cell: VideoCell = tableView.dequeueCell(indexPath)
            configureVideoCell(cell, props: props, addGradient: row.addGradient)
            return cell
            
        case .product:
            let cell: NestedCell = tableView.dequeueCell(indexPath)
            configureProductCell(cell, for: row)
            return cell
        }
    }
}

// MARK: - UITableViewDataSource

extension NewFromNikeCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        makeCell(for: rows[indexPath.row], at: indexPath)
    }
}

// MARK: - UITableViewDelegate

extension NewFromNikeCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rows[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectProduct(rows[indexPath.row])
    }
}

// MARK: - VisibilityTrackable

extension NewFromNikeCell: VisibilityTrackable {
    
    func handleVisibility() {
        tableView.visibleCells.forEach { cell in
            let frame = cell.convert(cell.bounds, to: nil)
            guard let window = window else { return }
            
            if frame.intersects(window.bounds) {
                lifecycleRouter.route(event: .willDisplay, for: cell)
            } else {
                lifecycleRouter.route(event: .didEndDisplaying, for: cell)
            }
        }
    }
}

// MARK: - View Configuration

private extension NewFromNikeCell {
    
    func configureView() {
        contentView.addSubview(headerStackView)
        contentView.addSubview(tableView)
        
        headerStackView.addArrangedSubview(headerTitleLabel)
        headerStackView.addArrangedSubview(headerButton)
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(NestedCell.self)
        tableView.registerCell(VideoCell.self)
    }
}

// MARK: - Layout

private extension NewFromNikeCell {
    
    func configureLayout() {
        [headerStackView, tableView, headerButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            // Header
            headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Header.top),
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Header.leading),
            
            headerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.Header.buttonTrailing),
            headerButton.topAnchor.constraint(equalTo: headerTitleLabel.topAnchor),
            headerButton.widthAnchor.constraint(equalToConstant: Constants.Header.buttonWidth),
            
            // TableView
            tableView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: Constants.Table.top),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.Table.bottom)
        ])
    }
}

// MARK: - Constants

private enum Constants {
    
    enum Header {
        static let top: CGFloat = 24
        static let leading: CGFloat = 24
        static let buttonTrailing: CGFloat = -12
        static let buttonWidth: CGFloat = 75
    }
    
    enum Table {
        static let top: CGFloat = 24
        static let bottom: CGFloat = -8
    }
}

// Make separate file for Constants

// Error Handling (comment for another file)
//    •    В HomeViewModel.handleError можно логировать ошибки для аналитики, сейчас просто отображается пользователю.


// В NewFromNikeCell можно инкапсулировать конфигурацию видео и продуктов в отдельный менеджер ячеек для большей чистоты
// •    Каждая ячейка имеет свой tableView внутри, что может быть дорогим по памяти при большом количестве таких ячеек. Можно рассмотреть diffable data source или collection view для оптимизации.



//import UIKit
//
//import AppDomain
//import DesignSystem
//import AppInterface
//
//final class NewFromNikeCell: UITableViewCell {
//    
//    // MARK: - UI
//    
//    private let headerTitleLabel = Label(type: .header)
//    private let headerStackView = StackView(type: .listHeader)
//    private lazy var headerButton = HeaderButton()
//    
//    /// Non-scrollable table view used to render heterogeneous content inside the cell.
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.isScrollEnabled = false
//        tableView.separatorStyle = .none
//        tableView.allowsSelection = true
//        return tableView
//    }()
//    
//    // MARK: - Data
//    
//    private var rows: [NewFromNikeRowProps] = []
//    
//    // MARK: - Layout
//    
//    private var tableViewHeightConstraint: NSLayoutConstraint?
//    
//    
//    // MARK: - Helpers
//    
//    private let lifecycleRouter: CellLifecycleRouting = DefaultCellLifecycleRouter()
//    var onAction: ((HomeCellAction) -> Void)?
//    
//    
//    // MARK: - Init
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//        setupHeaderButtonAction()
//        setupConstraints()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.registerCell(NestedCell.self)
//        tableView.registerCell(VideoCell.self)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        updateTableViewHeight(0)
//    }
//}
//
//// MARK: - Private Methods
//
//extension NewFromNikeCell {
//    private func selectProduct(_ row: NewFromNikeRowProps) {
//        onAction?(.newFromNike(.productSelected(row)))
//    }
//    
//    private func configureVideoCell(
//        _ cell: VideoCell,
//        props: NewFromNikeRowProps.VideoProps,
//        addGradient: Bool
//    ) {
//        cell.update(props: props, addGradient: addGradient, isMuted: true)
//        cell.onBottomButtonTapped = { [weak self] in
//            self?.onAction?(.newFromNike(.videoBottomButton))
//        }
//    }
//    
//    private func configureProductCell(
//        _ cell: NestedCell,
//        for row: NewFromNikeRowProps
//    ) {
//        switch row.content {
//        case .product(let props):
//            cell.updateHomeCell(with: props, addGradient: row.addGradient)
//            cell.onExploreButtonTapped = { [weak self] in
//                self?.selectProduct(row)
//            }
//        default: break
//        }
//    }
//    
//    private func makeCell(for row: NewFromNikeRowProps, at indexPath: IndexPath) -> UITableViewCell {
//        switch row.content {
//            
//        case .video(let props):
//            let cell: VideoCell = tableView.dequeueCell(indexPath)
//            configureVideoCell(cell, props: props, addGradient: row.addGradient)
//            return cell
//            
//        case .product:
//            let cell: NestedCell = tableView.dequeueCell(indexPath)
//            configureProductCell(cell, for: row)
//            return cell
//        }
//    }
//}
//
//// MARK: - VisibilityTrackable
//
//extension NewFromNikeCell: VisibilityTrackable {
//    func updateHeader(_ model: Header) {
//        headerTitleLabel.text = model.title
//        headerButton.customButton.setTitle(model.buttonTitle, for: .normal)
//    }
//    
//    func update(_ viewData: NewFromNikeSectionViewData) {
//        updateHeader(viewData.header)
//        rows = viewData.rows
//        updateTableViewHeight(rows.map(\.height).reduce(0, +))
//        tableView.reloadData()
//    }
//    
//    func updateTableViewHeight(_ height: CGFloat) {
//        tableViewHeightConstraint?.constant = height
//    }
//    
//    func handleVisibility() {
//        tableView.visibleCells.forEach { cell in
//            let frame = cell.convert(cell.bounds, to: nil)
//            guard let window = window else { return }
//            
//            if frame.intersects(window.bounds) {
//                lifecycleRouter.route(event: .willDisplay, for: cell)
//            } else {
//                lifecycleRouter.route(event: .didEndDisplaying, for: cell)
//            }
//        }
//    }
//}
//
//// MARK: - Action Handler
//
//extension NewFromNikeCell {
//    func setupHeaderButtonAction() {
//        headerButton.onButtonTapped = { [weak self] in
//            self?.onAction?(.newFromNike(.headerButton))
//        }
//    }
//}
//
////MARK: - UITableViewDataSource
//
//extension NewFromNikeCell: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return rows.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let row = rows[indexPath.row]
//        return makeCell(for: row, at: indexPath)
//    }
//}
//
////MARK: - UITableViewDelegate
//
//extension NewFromNikeCell: UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return rows[indexPath.row].height
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectProduct(rows[indexPath.row])
//    }
//}
//
//// MARK: - Layout
//
//private enum Constants {
//    static let stackTop: CGFloat = 24
//    static let stackLeading: CGFloat = 24
//    static let headerButtonTrailing: CGFloat = -12
//    static let headerButtonWidth: CGFloat = 75
//    static let tableViewBottom: CGFloat = -8
//    static let tableViewTop: CGFloat = 24
//}
//
//extension NewFromNikeCell {
//    
//    private func setupViews() {
//        contentView.addSubview(headerStackView)
//        contentView.addSubview(tableView)
//        headerStackView.addArrangedSubview(headerTitleLabel)
//        headerStackView.addArrangedSubview(headerButton)
//    }
//    
//    private func setupConstraints() {
//        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
//        tableViewHeightConstraint?.isActive = true
//        headerButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.stackTop),
//            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.stackLeading),
//            
//            headerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.headerButtonTrailing),
//            headerButton.topAnchor.constraint(equalTo: headerTitleLabel.topAnchor),
//            headerButton.widthAnchor.constraint(equalToConstant: Constants.headerButtonWidth),
//            
//            tableView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: Constants.tableViewTop),
//            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.tableViewBottom)
//        ])
//    }
//}




/*
Notes:
 
1.
 handleVisibility
    •    Сейчас проверяется пересечение frame с window.bounds. Можно вынести в helper:
 private func isCellVisible(_ cell: UITableViewCell) -> Bool
 Это сделает handleVisibility ещё чище.
 
 2.
 •    В setupConstraints использовать layoutMarginsGuide для ведущих/трейлинг, тогда 24 можно будет сделать layoutMargins.left и т.д., меньше “магических чисел”.
 
 3.
 Если хочется более компактно, makeCell(for:at:) можно сделать чуть короче, объединяя videoCell конфиг в одну функцию.
 4.
 Констрейнты
     •    Всё работает, но можно использовать NSLayoutConstraint.activate сразу при создании tableViewHeightConstraint, чтобы не держать .isActive = true отдельно.

*/
