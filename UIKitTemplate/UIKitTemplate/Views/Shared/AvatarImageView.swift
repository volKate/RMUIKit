// AvatarImageView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AvatarImageView: UIImageView {
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

    private func setupView() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
