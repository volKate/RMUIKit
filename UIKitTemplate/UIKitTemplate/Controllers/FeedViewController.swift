// FeedViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Лента постов
final class FeedViewController: UIViewController {
    // MARK: - Visual Components

    private lazy var feedTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.register(StoriesCell.self, forCellReuseIdentifier: StoriesCell.reuseID)
        table.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseID)
        table.register(RecommendationCell.self, forCellReuseIdentifier: RecommendationCell.reuseID)
        table.separatorStyle = .none
        table.rowHeight = UITableView.automaticDimension
        return table
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()

    // MARK: - Private Properties

    private let dataProvider = AppDataProvider()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupView()
    }

    // MARK: - Private Methods

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

// MARK: - FeedViewController + UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataProvider.feedSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataProvider.feedSections[section] {
        case .stories, .recommendation, .firstPost:
            return 1
        case .posts:
            return dataProvider.posts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataProvider.feedSections[indexPath.section] {
        case .stories:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StoriesCell.reuseID) as? StoriesCell
            else { return .init() }
            cell.stories = dataProvider.stories
            return cell
        case .firstPost:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseID) as? PostCell
            else { return .init() }
            cell.setupCell(withPost: dataProvider.firstPost)
            return cell
        case .posts:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseID) as? PostCell
            else { return .init() }
            cell.setupCell(withPost: dataProvider.posts[indexPath.row])
            return cell
        case .recommendation:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: RecommendationCell.reuseID) as? RecommendationCell
            else { return .init() }
            cell.setupCell(withRecommendations: dataProvider.recommendations)
            return cell
        }
    }
}
