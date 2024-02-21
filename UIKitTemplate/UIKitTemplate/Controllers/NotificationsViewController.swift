// NotificationsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран уведомлений
final class NotificationsViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let screenTitle = "Уведомления"
        static let subscribeRequestText = "Запросы на подписку"
    }

    // MARK: - Visual Components

    private let subscribeRequestLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 14)
        label.text = Constants.subscribeRequestText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var notificationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ThumbnailNotificationCell.self, forCellReuseIdentifier: ThumbnailNotificationCell.reuseID)
        tableView.register(SubscribeNotificationCell.self, forCellReuseIdentifier: SubscribeNotificationCell.reuseID)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        view.addSubview(subscribeRequestLabel)
        view.addSubview(notificationsTableView)
        setupConstraints()
    }

    private func setupNavigationItem() {
        title = Constants.screenTitle
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.verdanaBold(ofSize: 28) ?? UIFont.boldSystemFont(ofSize: 28)
        ]
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupConstraints() {
        [
            subscribeRequestLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            subscribeRequestLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            view.trailingAnchor.constraint(equalTo: subscribeRequestLabel.trailingAnchor, constant: 12),
            notificationsTableView.topAnchor.constraint(equalTo: subscribeRequestLabel.bottomAnchor, constant: 20),
            notificationsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notificationsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notificationsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].activate()
    }
}

// MARK: - NotificationsViewController + UITableViewDataSource

extension NotificationsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataProvider.notificationsTableHeaders.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataProvider.notificationsBySection[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notifications = dataProvider.notificationsBySection[indexPath.section]
        let notification = notifications[indexPath.row]
        switch notification.type {
        case .subscribe:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: SubscribeNotificationCell
                        .reuseID
                ) as? SubscribeNotificationCell else { return .init() }
            cell.setupCell(withNotification: notification)
            return cell
        case .post:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: ThumbnailNotificationCell
                        .reuseID
                ) as? ThumbnailNotificationCell else { return .init() }
            cell.setupCell(withNotification: notification)
            return cell
        }
    }
}

// MARK: - NotificationsViewController + UITableViewDelegate

extension NotificationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = makeSectionHeader(withText: dataProvider.notificationsTableHeaders[section])
        return headerView
    }

    private func makeSectionHeader(withText text: String) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 14)
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        [
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -13),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor)
        ].activate()
        return headerView
    }
}
