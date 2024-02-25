// PostCollectionCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка поста в профиле
final class PostCollectionCell: UICollectionViewCell {
    static let reuseID = String(describing: PostCollectionCell.self)

    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.disableAutoresizingMask()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    func configure(withPost post: Post) {
        postImageView.image = UIImage(named: post.postImages.first ?? "")
    }

    private func setupCell() {
        contentView.addSubview(postImageView)
        setupConstraints()
    }

    private func setupConstraints() {
        [
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ].activate()
    }
}
