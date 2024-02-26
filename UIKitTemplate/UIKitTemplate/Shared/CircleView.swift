// CircleView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кгруглый View
final class CircleView: UIView {
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Public Methods

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = min(rect.width, rect.height) / 2
    }

    // MARK: - Private Methods

    private func setupView() {
        clipsToBounds = true
        contentMode = .redraw
    }
}
