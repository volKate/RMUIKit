// ProfileLinkViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Отображение содержимого ссылки в профиле
final class ProfileLinkViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let goBackButtonImage = "chevron.left.2"
        static let goForwardButtonImage = "chevron.right.2"
        static let refreshButtonImage = "arrow.counterclockwise"
    }

    // MARK: - Visual Components

    private let webView = WKWebView()

    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        let goBackButton = makeToolbarButton(image: UIImage(systemName: Constants.goBackButtonImage))
        let goForwardButton = makeToolbarButton(image: UIImage(systemName: Constants.goForwardButtonImage))
        let refreshButton = makeToolbarButton(image: UIImage(systemName: Constants.refreshButtonImage))
        let spacingItem = UIBarButtonItem(systemItem: .flexibleSpace)
        goBackButton.action = #selector(handleGoBack)
        goForwardButton.action = #selector(handleGoForward)
        refreshButton.action = #selector(handleRefreshPage)
        toolbar.items = [goBackButton, goForwardButton, spacingItem, refreshButton]
        toolbar.disableAutoresizingMask()
        return toolbar
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    func configure(withLink link: String) {
        guard let url = URL(string: link) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }

    // MARK: - Private Methods

    private func setupView() {
        webView.disableAutoresizingMask()
        view.addSubviews(webView, toolbar)
        setupConstraints()
    }

    private func setupConstraints() {
        [
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.topAnchor.constraint(equalTo: webView.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: webView.trailingAnchor)
        ].activate()
    }

    private func makeToolbarButton(image: UIImage?) -> UIBarButtonItem {
        let button = UIBarButtonItem()
        button.image = image
        button.tintColor = .blackMain
        return button
    }

    @objc private func handleGoBack() {
        guard webView.canGoBack else { return }
        webView.goBack()
    }

    @objc private func handleGoForward() {
        guard webView.canGoForward else { return }
        webView.goForward()
    }

    @objc private func handleRefreshPage() {
        webView.reload()
    }
}
