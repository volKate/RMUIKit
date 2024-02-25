// BaseLabel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Лейбл в шрифте Verdana
class BaseLabel: UILabel {
    // MARK: - Initializers

    init(text: String = "", size: CGFloat = 14) {
        super.init(frame: .zero)
        self.text = text
        setupLabel(withSize: size)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }

    // MARK: - Private Methods

    private func setupLabel(withSize size: CGFloat = 14) {
        font = .verdana(ofSize: size)
        disableAutoresizingMask()
    }
}
