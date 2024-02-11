// UnderlinedTextField.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// UITextField with border bottom
final class UnderlinedTextField: UITextField {
    // MARK: - Constants

    private static let borderWidth = 1.0
    private static let spacing = 9.0

    // MARK: - Public Properties

    override var frame: CGRect {
        didSet {
            borderLayer?.frame = CGRect(
                x: 0,
                y: bounds.maxY + UnderlinedTextField.spacing,
                width: frame.size.width,
                height: UnderlinedTextField.borderWidth
            )
        }
    }

    // MARK: - Private Properties

    private var borderLayer: CALayer?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextFied()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextFied()
    }

    // MARK: - Private Methods

    private func setupTextFied() {
        font = UIFont(name: "Verdana", size: 14)
        let border = CALayer()
        border.backgroundColor = UIColor.grayMain.cgColor
        borderLayer = border
        layer.addSublayer(border)
    }
}
