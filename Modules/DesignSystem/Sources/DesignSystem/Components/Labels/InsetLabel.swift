//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/22/25.
//

import UIKit

public class InsetLabel: UILabel {

    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }

    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: contentInset))
    }

    public override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height += contentInset.top + contentInset.bottom
        size.width += contentInset.left + contentInset.right
        return size
    }

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
