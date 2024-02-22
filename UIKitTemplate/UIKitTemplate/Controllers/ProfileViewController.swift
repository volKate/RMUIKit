// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля
final class ProfileViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let screenTitle = "Профиль"
        static let addPostButtonImage = "plus.app"
        static let menuButtonImage = "line.3.horizontal"
    }

    // MARK: - Visual Components

    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(AccountInfoCell.self, forCellReuseIdentifier: AccountInfoCell.reuseID)
        tableView.register(StoriesCell.self, forCellReuseIdentifier: StoriesCell.reuseID)
        tableView.register(PostsGridCell.self, forCellReuseIdentifier: PostsGridCell.reuseID)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handlePageRefresh(_:)), for: .valueChanged)
        refreshControl.layer.zPosition = -1
        tableView.refreshControl = refreshControl
        tableView.disableAutoresizingMask()
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    // MARK: - Private Properties

    private let dataProvider = DataProvider()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.addSubview(profileTableView)
        setupConstraints()
    }

    private func setupConstraints() {
        [
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].activate()
    }

    private func setupNavigationItem() {
        let addPostButton = makeBarButtonItem(
            image: UIImage(systemName: Constants.addPostButtonImage)
        )
        let menuButton = makeBarButtonItem(image: UIImage(systemName: Constants.menuButtonImage))
        let lockButton = makeBarButtonItem(image: .lock)
        let accountButton = makeBarButtonItem(text: dataProvider.currentUserAccount.name)
        navigationItem.setRightBarButtonItems([menuButton, addPostButton], animated: false)
        navigationItem.setLeftBarButtonItems([lockButton, accountButton], animated: false)
    }

    private func makeBarButtonItem(image: UIImage? = nil, text: String? = nil) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.tintColor = .blackMain
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .verdanaBold(ofSize: 18)
        button.titleLabel?.textColor = .blackMain
        button.disableAutoresizingMask()
        if text == nil {
            button.widthAnchor.constraint(equalToConstant: 24).activate()
        }
        return UIBarButtonItem(customView: button)
    }

    @objc private func handlePageRefresh(_ refreshControl: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            refreshControl.endRefreshing()
        }
    }
}

// MARK: - ProfileViewController + UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = dataProvider.profileSections[indexPath.section]
        switch sectionType {
        case .accountInfo:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: AccountInfoCell.reuseID) as? AccountInfoCell
            else { return .init() }
            cell.configure(withAccount: dataProvider.currentUserAccount)
            return cell
        case .highlights:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: StoriesCell.reuseID) as? StoriesCell
            else { return .init() }
            cell.configure(withHighlights: dataProvider.highlights)
            return cell

        case .postsGrid:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsGridCell.reuseID) as? PostsGridCell
            else { return .init() }
            return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        dataProvider.profileSections.count
    }
}
