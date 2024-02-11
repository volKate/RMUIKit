// BaseLabel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// BaseLabel is a label with preset Verdana font
final class BaseLabel: UILabel {
    // MARK: - Initializers

    init(size: CGFloat, bold: Bool = false) {
        super.init(frame: .zero)
        font = UIFont(name: bold ? "Verdana-Bold" : "Verdana", size: size)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
