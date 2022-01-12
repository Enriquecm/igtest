//
//  ArticleDetailViewController.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    private let viewModel: ArticleDetailViewModel

    // MARK: - UI Elements

    private let articleDetailView = ArticleDetailView()

    // MARK: - Life Cycle

    init(viewModel: ArticleDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupArticleDetailView()
    }

    // MARK: - Private methods

    private func setupUI() {
        edgesForExtendedLayout = [.bottom]
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = ColorPalette.background

        articleDetailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(articleDetailView)

        NSLayoutConstraint.activate([
            articleDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0),
            articleDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            view.trailingAnchor.constraint(equalTo: articleDetailView.trailingAnchor, constant: 16.0),
            view.bottomAnchor.constraint(greaterThanOrEqualTo: articleDetailView.bottomAnchor, constant: 16.0)
        ])
    }

    private func setupArticleDetailView() {
        articleDetailView.setup(with: viewModel.report)
    }
}
