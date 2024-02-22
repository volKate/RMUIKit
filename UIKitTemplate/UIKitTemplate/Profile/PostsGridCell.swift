// PostsGridCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Посты
final class PostsGridCell: UITableViewCell {
    static let reuseID = String(describing: PostCell.self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .blue
    }
}
