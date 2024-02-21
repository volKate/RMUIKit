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

    convenience init() {
        self.init(frame: .zero)
    }

    override init(image: UIImage?) {
        super.init(image: image)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupView() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
