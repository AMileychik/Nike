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

// MARK: - NewFromNikeCell

/// UITableViewCell responsible for displaying a heterogeneous list of NewFromNike content.
///
/// Responsibilities:
/// - Shows a header with title and optional button.
/// - Contains a non-scrollable table view to render videos and product cells.
/// - Handles product selection and video button actions via callback.
final class NewFromNikeCell: UITableViewCell {

    // MARK: - UI Components

    private let headerTitleLabel = Label(type: .header)
    private let headerStackView = StackView(type: .listHeader)
    private lazy var headerButton = HeaderButton()

    /// Non-scrollable table view for heterogeneous content
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

    // MARK: - Initialization

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

    /// Updates cell with new view data
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

// MARK: - Header Configuration

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
        [headerStackView, tableView, headerButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

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

// MARK: - Layout Constants

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




