// AvatarImageView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Скругленная аватарка
final class AvatarImageView: UIImageView {
    // MARK: - Public Properties

    var size: CGFloat? {
        didSet {
            if let size {
                [
                    heightAnchor.constraint(equalToConstant: size),
                    widthAnchor.constraint(equalTo: heightAnchor)
                ].activate()
                layer.cornerRadius = size / 2
            }
        }
    }

    // MARK: - Initializers

    override init(image: UIImage?) {
        super.init(image: image)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    convenience init() {
        self.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
