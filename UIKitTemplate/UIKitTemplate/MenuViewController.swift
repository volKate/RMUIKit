// MenuViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Меню выбора светофора
final class MenuViewController: UIViewController {
    // MARK: - Visual Components

    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Private Properties

    private let tableConfiguration = MenuTableConfiguration()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.addSubview(menuTableView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

// MARK: - MenuViewController + UITableViewDataSource

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableConfiguration.lightsTaskImplementations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let implementation = tableConfiguration.lightsTaskImplementations[indexPath.row]
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = tableConfiguration.taskImplementationsNameMap[implementation]
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - MenuViewController + UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let implementation = tableConfiguration.lightsTaskImplementations[indexPath.row]
        switch implementation {
        case .storyboard:
            guard let lightsStoryboardviewController = UIStoryboard(
                name: tableConfiguration.storyboardName,
                bundle: .main
            )
            .instantiateViewController(
                withIdentifier: tableConfiguration.storyboardViewControllerId
            ) as? LightsStoryboardViewController
            else { return }
            navigationController?.pushViewController(lightsStoryboardviewController, animated: true)
        case .anchors:
            let lightsAnchorsViewController = LightsAnchorsViewController()
            navigationController?.pushViewController(lightsAnchorsViewController, animated: true)
        case .nsConstraints:
            let lightsConstraintsViewController = LightsConstraintsViewController()
            navigationController?.pushViewController(lightsConstraintsViewController, animated: true)
        case .stackView:
            let lightsStackViewController = LightsStackViewController()
            navigationController?.pushViewController(lightsStackViewController, animated: true)
        default:
            break
        }
    }
}
