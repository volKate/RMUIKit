// RemindersListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// VC with the list of birthday reminders ordered by most close ones first
final class RemindersListViewController: UIViewController {
    // MARK: - Private Properties

    private lazy var reminders = [
        makeReminder(
            avatar: .helenaAvatar,
            name: "Helena Link",
            date: "10.03 - turns 25!",
            countDown: "10\ndays"
        ),
        makeReminder(
            avatar: .veronaAvatar,
            name: "Verona Tusk",
            date: "20.03 - turns 39",
            countDown: "10\ndays"
        ),
        makeReminder(
            avatar: .alexAvatar,
            name: "Alex Smith",
            date: "21.04 - turns 51",
            countDown: "42\ndays"
        ),
        makeReminder(
            avatar: .tomAvatar,
            name: "Tom Johnson",
            date: "05.06 - turns 18",
            countDown: "87\ndays"
        )
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupReminders()
    }

    // MARK: - Private Methods

    private func setupReminders() {
        for (index, reminder) in reminders.enumerated() {
            reminder.frame = CGRect(origin: CGPoint(x: 20, y: (index + 1) * 100), size: reminder.frame.size)
            view.addSubview(reminder)
        }
    }

    private func setupNav() {
        title = "Birthday Reminder"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addReminder))
        addButton.action = #selector(addReminder)
        navigationItem.setRightBarButton(addButton, animated: false)
    }

    @objc private func addReminder() {
        let addReminderVC = AddReminderViewController()
        addReminderVC.handleAdd = { [weak self] data in
            self?.addReminderView(data)
        }
        addReminderVC.modalPresentationStyle = .pageSheet
        present(UINavigationController(rootViewController: addReminderVC), animated: true)
    }

    private func addReminderView(_ data: ReminderFormData) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let birthdayString = formatter.string(from: data.birthday)
        let reminder = makeReminder(
            avatar: .avatarPlaceholder,
            name: data.fullName,
            date: "\(birthdayString) - turns \(data.age + 1)",
            countDown: "20\ndays"
        )
        reminder.frame = CGRect(origin: CGPoint(x: 20, y: 500), size: reminder.frame.size)
        view.addSubview(reminder)
    }

    // factories
    private func makeReminder(avatar: UIImage?, name: String, date: String, countDown: String) -> UIView {
        let view = UIView()
        view.frame = CGRect(origin: .zero, size: CGSize(width: 335, height: 93))
        let avatarImage = makeAvatarImage(image: avatar)
        let nameLabel = makePersonNameLabel(text: name)
        let dateLabel = makeDateLabel(text: date)
        let countDownLabel = makeCountDownLabel(text: countDown)

        avatarImage.frame = CGRect(origin: CGPoint(x: 8, y: 9), size: avatarImage.frame.size)
        nameLabel.frame = CGRect(x: 90, y: 25, width: 180, height: 20)
        dateLabel.frame = CGRect(x: 90, y: 53, width: 180, height: 20)
        countDownLabel.frame = CGRect(x: 280, y: 25, width: 42, height: 44)

        view.addSubview(avatarImage)
        view.addSubview(nameLabel)
        view.addSubview(dateLabel)
        view.addSubview(countDownLabel)

        return view
    }

    private func makePersonNameLabel(text: String) -> UILabel {
        let label = BaseLabel(size: 16, bold: true)
        label.text = text
        label.numberOfLines = 0
        return label
    }

    private func makeCountDownLabel(text: String) -> UILabel {
        let label = BaseLabel(size: 16, bold: true)
        label.text = text
        label.textColor = .purpleMain
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }

    private func makeDateLabel(text: String) -> UILabel {
        let label = BaseLabel(size: 14)
        label.text = text
        label.numberOfLines = 0
        return label
    }

    private func makeAvatarImage(image: UIImage?) -> UIImageView {
        let avatar = UIImageView(image: image)
        avatar.layer.cornerRadius = 40
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.gray.cgColor
        avatar.frame = CGRect(origin: .zero, size: CGSize(width: 75, height: 75))
        return avatar
    }
}
