// BaseBoldLabel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Лейбл в шрифте Verdana Bold
final class BaseBoldLabel: BaseLabel {
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }

    override init(text: String = "", size: CGFloat = 14) {
        super.init(text: text, size: size)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }

    // MARK: - Private Methods

    private func setupLabel() {
        font = .verdanaBold(ofSize: 14)
    }
}
