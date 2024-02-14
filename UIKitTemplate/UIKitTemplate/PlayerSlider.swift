// PlayerSlider.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Custom Slider with preset thumbImage and trackHeight (default: 8.0);
/// with ability to set rotation in degrees and trackHeight through storyboard
class PlayerSlider: UISlider {
    // MARK: - Public Properties

    @IBInspectable var trackHeight: CGFloat = 8.0
    @IBInspectable var rotationDegrees: CGFloat = 0 {
        didSet {
            let rotationRadians = rotationDegrees * Double.pi / 180
            layer.setAffineTransform(.init(rotationAngle: rotationRadians))
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupThumb()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupThumb()
    }

    // MARK: - Public Methods

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
    }

    // MARK: - Private Methods

    private func setupThumb() {
        setThumbImage(.thumb, for: .normal)
    }
}
