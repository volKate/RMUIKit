// PostsGridCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Посты
final class PostsGridCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let itemsSpacing = 1.5
        static let itemsPerRow = 3.0
    }

    static let reuseID = String(describing: PostsGridCell.self)

    // MARK: - Visual Components

    private lazy var postsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeFlowLayout())
        collectionView.disableAutoresizingMask()
        collectionView.register(PostCollectionCell.self, forCellWithReuseIdentifier: PostCollectionCell.reuseID)
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private var posts: [Post] = []

    // MARK: - Public Methods

    func configure(withPosts posts: [Post]) {
        self.posts = posts
        postsCollectionView.reloadData()
        setCollectionHeight()
    }

    // MARK: - Private Methods

    private func setupCell() {
        selectionStyle = .none
        contentView.addSubview(postsCollectionView)
        setupConstraints()
    }

    private func setCollectionHeight() {
        let rowsCount = (Double(posts.count) / Constants.itemsPerRow).rounded(.up)
        let spacingHeight = (rowsCount - 1) * Constants.itemsSpacing
        let availableWidth = UIScreen.main.bounds.width - Constants.itemsSpacing * (Constants.itemsPerRow - 1)
        let itemHeight = availableWidth / Constants.itemsPerRow
        let collectionHeight = rowsCount * itemHeight + spacingHeight
        postsCollectionView.heightAnchor.constraint(equalToConstant: collectionHeight).activate()
    }

    private func setupConstraints() {
        [
            postsCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            postsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ].activate()
    }

    private func makeFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1.5
        flowLayout.minimumInteritemSpacing = 1.5
        return flowLayout
    }
}

// MARK: - PostsGridCell + UICollectionViewDataSource

extension PostsGridCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PostCollectionCell.reuseID,
            for: indexPath
        ) as? PostCollectionCell else { return .init() }

        cell.configure(withPost: posts[indexPath.item])
        return cell
    }
}

// MARK: - PostsGridCell + UICollectionViewDelegateFlowLayout

extension PostsGridCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let availableWidth = contentView.frame.width - Constants.itemsSpacing * (Constants.itemsPerRow - 1)
        let width = availableWidth / Constants.itemsPerRow
        return CGSize(width: width, height: width)
    }
}
