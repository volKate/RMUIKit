// AddReminderViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// VC with the new reminder creation form
class AddReminderViewController: UIViewController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNav()
    }

    // MARK: - Private Methods

    private func setupNav() {
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissForm))
        navigationItem.setRightBarButton(addButton, animated: false)
        navigationItem.setLeftBarButton(cancelButton, animated: false)
    }

    @objc private func dismissForm() {
        dismiss(animated: true)
    }
}
