// FeedViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Лента постов
final class FeedViewController: UIViewController {
    private enum FeedCellType: String {
        case stories = "StoriesCell"
    }

    private lazy var feedTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(StoriesCell.self, forCellReuseIdentifier: FeedCellType.stories.rawValue)
        table.separatorStyle = .none
        table.rowHeight = UITableView.automaticDimension
        return table
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupView()
    }

    private func setupView() {
        feedTableView.addSubview(refreshControl)
        view.addSubview(feedTableView)

        setupContraints()
    }

    private func setupContraints() {
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        [
            feedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].activate()
    }

    // MARK: - Private Methods

    private func setupNavigationItem() {
        let messagesBarItem = UIBarButtonItem(image: .messagesBarIcon.withRenderingMode(.alwaysOriginal))
        let logoBarItem = UIBarButtonItem(image: .logo.withRenderingMode(.alwaysOriginal))
        navigationItem.setRightBarButton(messagesBarItem, animated: false)
        navigationItem.setLeftBarButton(logoBarItem, animated: false)
    }

    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FeedCellType.stories.rawValue,
            for: indexPath
        ) as? StoriesCell else { fatalError("No such cell") }
        return cell
    }
}
