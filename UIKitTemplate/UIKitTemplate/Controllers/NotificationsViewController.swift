// NotificationsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class NotificationsViewController: UIViewController {
    enum Constants {
        static let screenTitle = "Уведомления"
        static let subscribeRequestText = "Запросы на подписку"
        static let todaySectionTitle = "Сегодня"
        static let thisWeekSectionTitle = "На этой неделе"
    }

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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupView()
    }

    private func setupView() {
        view.addSubview(subscribeRequestLabel)
        view.addSubview(notificationsTableView)
        setupConstraints()
    }

    private func setupNavigationItem() {
        let titleLabel = UILabel()
        titleLabel.font = .verdanaBold(ofSize: 22)
        titleLabel.text = Constants.screenTitle
        titleLabel.textAlignment = .left
        navigationItem.setLeftBarButton(UIBarButtonItem(customView: titleLabel), animated: false)
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

extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return AppDataProvider.shared.todaysNotifications.count
        case 1:
            return AppDataProvider.shared.thisWeekNotifications.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var notification: LinkNotification?
        switch indexPath.section {
        case 0:
            notification = AppDataProvider.shared.todaysNotifications[indexPath.row]
        case 1:
            notification = AppDataProvider.shared.thisWeekNotifications[indexPath.row]
        default:
            break
        }

        if let notification {
            if notification.postThumbnail == nil {
                guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: SubscribeNotificationCell
                            .reuseID
                    ) as? SubscribeNotificationCell else { return UITableViewCell() }
                cell.setupCell(withNotification: notification)
                return cell
            } else {
                guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: ThumbnailNotificationCell
                            .reuseID
                    ) as? ThumbnailNotificationCell else { return UITableViewCell() }
                cell.setupCell(withNotification: notification)
                return cell
            }
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        [
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -13),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor)
        ].activate()
        switch section {
        case 0:
            label.text = Constants.todaySectionTitle
        case 1:
            label.text = Constants.thisWeekSectionTitle
        default:
            break
        }
        return headerView
    }
}
