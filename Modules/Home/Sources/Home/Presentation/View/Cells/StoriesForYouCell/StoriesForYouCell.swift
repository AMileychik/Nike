//
//  AlwaysPopularCell.swift
//  Nike
//
//  Created by Александр Милейчик on 10/9/25.
//

import UIKit

import DesignSystem
import AppDomain
import AppInterface

// MARK: - Models

/// Represents the slot a story item occupies in the view.
public enum StorySlot {
    case large
    case small1
    case small2
}

/// Wrapper for a story item along with its slot.
public struct StoryItem<Item: StoriesForYouPropsProtocol> {
    public let slot: StorySlot
    public let props: Item
}

/// Section model for "Stories For You" content.
public struct StoriesForYouSection<Item: StoriesForYouPropsProtocol, Header: BecauseYouLikeHeader> {

    public let header: Header
    public let items: [StoryItem<Item>]

    public init(header: Header, props: Item) {
        self.header = header
        self.items = [
            StoryItem(slot: .large,  props: props),
            StoryItem(slot: .small1, props: props),
            StoryItem(slot: .small2, props: props)
        ]
    }

    func item(for slot: StorySlot) -> StoryItem<Item>? {
        items.first { $0.slot == slot }
    }
}

// MARK: - Alignment DSL

enum AlignmentType {
    case fill
    case leading
    case center
    case trailing

    var toUIStackAlignment: UIStackView.Alignment {
        switch self {
        case .fill: return .fill
        case .leading: return .leading
        case .center: return .center
        case .trailing: return .trailing
        }
    }
}

/// Vertical stack wrapper.
final class VStack: UIStackView {
    init(_ arranged: [UIView], spacing: CGFloat = 0, alignment: AlignmentType) {
        super.init(frame: .zero)
        axis = .vertical
        arranged.forEach { addArrangedSubview($0) }
        self.spacing = spacing
        self.alignment = alignment.toUIStackAlignment
    }

    required init(coder: NSCoder) { fatalError("init(coder:) not implemented") }
}

/// Horizontal stack wrapper.
final class HStack: UIStackView {
    init(_ arranged: [UIView], spacing: CGFloat = 0, alignment: AlignmentType) {
        super.init(frame: .zero)
        axis = .horizontal
        arranged.forEach { addArrangedSubview($0) }
        self.spacing = spacing
        self.alignment = alignment.toUIStackAlignment
    }

    required init(coder: NSCoder) { fatalError("init(coder:) not implemented") }
}

// MARK: - UIView Helpers

extension UIView {
    /// Pins view to edges of its superview or a specified view
    func pinToEdges(of superview: UIView? = nil, insets: UIEdgeInsets = .zero) {
        let sv = superview ?? self.superview!
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: sv.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: sv.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: sv.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: -insets.bottom)
        ])
    }

    /// Adds a tap gesture recognizer
    @discardableResult
    func onTap(_ action: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        addGestureRecognizer(TapGesture(action: action))
        return self
    }
}

// MARK: - Tap Gesture Helper

final class TapGesture: UITapGestureRecognizer {
    private let action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(handle))
    }

    @objc private func handle() { action() }
}

// MARK: - Constants

private enum Constants {
    static let contentInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    static let mainStackSpacing: CGFloat = 16
    static let verticalStackSpacing: CGFloat = 8
    static let smallRowSpacing: CGFloat = 16
    static let bottomButtonHeight: CGFloat = 50
    static let largeImageAspectRatio: CGFloat = 1.0
    static let smallImageAspectRatio: CGFloat = 1.0
}

private enum ButtonStyle {
    static let cornerRadius: CGFloat = 24
    static let borderWidth: CGFloat = 1
    static let borderColor: UIColor = .gray
    static let backgroundColor: UIColor = UIColor.black.adjustBrightness(by: 0.1) ?? .black
    static let titleColor: UIColor = .white
}

// MARK: - StoriesForYouView

/// UIView representing a "Stories For You" section
public final class StoriesForYouView<Item: StoriesForYouPropsProtocol, Header: BecauseYouLikeHeader>: UIView {

    // MARK: - Callbacks
    var onAction: ((HomeCellAction) -> Void)?
    private var section: StoriesForYouSection<Item, Header>?

    // MARK: - UI Components
    private let headerLabel = Label(type: .header)
    private let headerButton = HeaderButton()

    private let largeImage = ImageView(type: .alwaysPopular)
    private let largeImageLabel1 = Label(type: .alwaysPopular)
    private let largeImageLabel2 = Label(type: .alwaysPopularBoltWeight)

    private let small1Image = ImageView(type: .alwaysPopular)
    private let smallImage1Label1 = Label(type: .alwaysPopular)
    private let smallImage1Label2 = Label(type: .alwaysPopularBoltWeight)

    private let small2Image = ImageView(type: .alwaysPopular)
    private let smallImage2Label1 = Label(type: .alwaysPopular)
    private let smallImage2Label2 = Label(type: .alwaysPopularBoltWeight)

    private let bottomButton = HeaderButton()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
        bindActions()
        configureHeaderButton()
        configureBottomButton()
    }

    required init?(coder: NSCoder) { nil }

    // MARK: - Public Methods

    func configure(with section: StoriesForYouSection<Item, Header>) {
        self.section = section
        let props = section.items[0].props

        // Header
        headerLabel.text = section.header.title
        headerButton.customButton.setTitle(section.header.buttonTitle, for: .normal)

        // Large
        largeImage.image = UIImage(named: props.large)
        largeImageLabel1.text = props.largeImageLabel1
        largeImageLabel2.text = props.title

        // Small 1
        small1Image.image = UIImage(named: props.small1)
        smallImage1Label1.text = props.title
        smallImage1Label2.text = props.title

        // Small 2
        small2Image.image = UIImage(named: props.small2)
        smallImage2Label1.text = props.title
        smallImage2Label2.text = props.title

        bottomButton.customButton.setTitle(props.bottomButtonTitle, for: .normal)
    }

    // MARK: - Button Configuration

    private func configureHeaderButton() {
        headerLabel.textColor = .white
        headerButton.customButton.setTitleColor(ButtonStyle.titleColor, for: .normal)
        headerButton.customButton.backgroundColor = ButtonStyle.backgroundColor
    }

    private func configureBottomButton() {
        bottomButton.customButton.setTitleColor(ButtonStyle.titleColor, for: .normal)
        bottomButton.customButton.layer.cornerRadius = ButtonStyle.cornerRadius
        bottomButton.customButton.layer.borderColor = ButtonStyle.borderColor.cgColor
        bottomButton.customButton.layer.borderWidth = ButtonStyle.borderWidth
        bottomButton.customButton.backgroundColor = ButtonStyle.backgroundColor
    }
}

// MARK: - UI Setup

private extension StoriesForYouView {

    func buildUI() {
        backgroundColor = UIColor.black.adjustBrightness(by: 0.1)

        // Stacks for large and small images
        let largeStack = VStack([
            largeImage,
            largeImageLabel1,
            largeImageLabel2
        ], spacing: Constants.verticalStackSpacing, alignment: .fill)

        let small1Stack = VStack([
            small1Image,
            smallImage1Label1,
            smallImage1Label2
        ], spacing: Constants.verticalStackSpacing, alignment: .fill)

        let small2Stack = VStack([
            small2Image,
            smallImage2Label1,
            smallImage2Label2
        ], spacing: Constants.verticalStackSpacing, alignment: .fill)

        let smallRow = HStack([small1Stack, small2Stack], spacing: Constants.smallRowSpacing, alignment: .fill)
        let headerRow = HStack([headerLabel, headerButton], alignment: .center)

        let content = VStack([
            headerRow,
            largeStack,
            smallRow,
            bottomButton
        ], spacing: Constants.mainStackSpacing, alignment: .fill)

        addSubview(content)
        content.pinToEdges(insets: Constants.contentInset)

        NSLayoutConstraint.activate([
            largeImage.heightAnchor.constraint(equalTo: largeImage.widthAnchor, multiplier: Constants.largeImageAspectRatio),
            small1Image.heightAnchor.constraint(equalTo: small1Image.widthAnchor, multiplier: Constants.smallImageAspectRatio),
            small2Image.heightAnchor.constraint(equalTo: small2Image.widthAnchor, multiplier: Constants.smallImageAspectRatio),
            bottomButton.heightAnchor.constraint(equalToConstant: Constants.bottomButtonHeight)
        ])
    }

    func bindActions() {
        headerButton.onButtonTapped = { [weak self] in
            self?.onAction?(.storiesForYou(.headerButton))
        }

        bottomButton.onButtonTapped = { [weak self] in
            self?.onAction?(.storiesForYou(.bottomButton))
        }

        largeImage.onTap { [weak self] in self?.handleTap(.large) }
        small1Image.onTap { [weak self] in self?.handleTap(.small1) }
        small2Image.onTap { [weak self] in self?.handleTap(.small2) }
    }

    func handleTap(_ slot: StorySlot) {
        guard let item = section?.item(for: slot) else { return }
        let model = item.props.product
        self.onAction?(.storiesForYou(.storySelected([model])))
    }
}

// MARK: - StoriesForYouCell

/// UITableViewCell wrapper for StoriesForYouView
final class StoriesForYouCell<Item: StoriesForYouPropsProtocol, Header: BecauseYouLikeHeader>: UITableViewCell {

    private let storiesView = StoriesForYouView<Item, Header>()

    var onAction: ((HomeCellAction) -> Void)? {
        didSet { storiesView.onAction = onAction }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(storiesView)
        storiesView.pinToEdges(of: contentView)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }

    required init?(coder: NSCoder) { nil }

    func update(with section: StoriesForYouSection<Item, Header>) {
        storiesView.configure(with: section)
    }
}

