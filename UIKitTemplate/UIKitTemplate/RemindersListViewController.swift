// RemindersListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// VC with the list of birthday reminders ordered by most close ones first
final class RemindersListViewController: UIViewController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
    }

    // MARK: - Private Methods

    private func setupNav() {
        title = "Birthday Reminder"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addReminder))
        addButton.action = #selector(addReminder)
        navigationItem.setRightBarButton(addButton, animated: false)
    }

    @objc private func addReminder() {
        let addReminderVC = AddReminderViewController()
        addReminderVC.modalPresentationStyle = .popover
        present(UINavigationController(rootViewController: addReminderVC), animated: true)
    }
}
