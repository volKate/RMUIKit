// StoryViewerViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Полноэкранная история
final class StoryViewerViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let closeButtonImage = "xmark"
    }

    // MARK: - Visual Components

    private let timerSlider: UISlider = {
        let slider = UISlider()
        slider.maximumTrackTintColor = .grayMain
        slider.minimumTrackTintColor = .whiteMain
        slider.setThumbImage(UIImage(), for: .normal)
        slider.disableAutoresizingMask()
        return slider
    }()

    private let storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.disableAutoresizingMask()
        return imageView
    }()

    private let storyThumbnailView: UIImageView = {
        let imageView = AvatarImageView()
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.whiteMain.cgColor
        imageView.size = 26
        return imageView
    }()

    private let storyNameLabel: UILabel = {
        let label = BaseLabel(size: 10)
        label.textColor = .whiteMain
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.closeButtonImage), for: .normal)
        button.tintColor = .whiteMain
        button.disableAutoresizingMask()
        button.addTarget(self, action: #selector(closeViewer), for: .touchUpInside)
        return button
    }()

    // MARK: - Private Properties

    private var timer = Timer()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [weak self] timer in
            if self?.timerSlider.value != 1 {
                self?.timerSlider.value += 0.005
            } else {
                timer.invalidate()
                self?.closeViewer()
            }
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }

    // MARK: - Public Methods

    func configure(withStory story: Story) {
        storyImageView.image = UIImage(named: story.imageName)
        storyThumbnailView.image = UIImage(named: story.imageName)
        storyNameLabel.text = story.highlightName
    }

    // MARK: - Private Methods

    private func setupView() {
        view.addSubviews(storyImageView, timerSlider, storyThumbnailView, storyNameLabel, closeButton)
        setupConstraints()
    }

    private func setupConstraints() {
        [
            storyImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            storyImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            storyImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            storyImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            timerSlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11),
            timerSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            view.trailingAnchor.constraint(equalTo: timerSlider.trailingAnchor, constant: 5),

            storyThumbnailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            storyThumbnailView.topAnchor.constraint(equalTo: timerSlider.bottomAnchor, constant: 9),
            storyNameLabel.leadingAnchor.constraint(equalTo: storyThumbnailView.trailingAnchor, constant: 7),
            storyNameLabel.centerYAnchor.constraint(equalTo: storyThumbnailView.centerYAnchor),
            view.trailingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 5),
            closeButton.centerYAnchor.constraint(equalTo: storyThumbnailView.centerYAnchor)
        ].activate()
    }

    @objc private func closeViewer() {
        dismiss(animated: true)
    }
}
