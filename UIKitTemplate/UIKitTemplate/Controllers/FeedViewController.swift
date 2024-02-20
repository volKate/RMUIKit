// FeedViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Лента постов
final class FeedViewController: UIViewController {
    private enum FeedSectionType {
        case post(Bool)
        case stories
        case recommendation
    }

    private let sections = [FeedSectionType.stories, .post(true), .recommendation, .post(false)]
    private let dataProvider = FeedDataProvider()

    private lazy var feedTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(StoriesCell.self, forCellReuseIdentifier: StoriesCell.reuseID)
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

// MARK: - UITableViewDelegate

extension FeedViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .stories, .recommendation:
            return 1
        case let .post(isFirst) where isFirst:
            return 1
        case .post:
            return dataProvider.postsCount - 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .stories:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StoriesCell.reuseID) as? StoriesCell
            else { return UITableViewCell() }
            cell.stories = dataProvider.getStories()
            return cell
        default:
            return UITableViewCell()
        }
    }
}
