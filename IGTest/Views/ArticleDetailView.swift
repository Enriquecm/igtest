//
//  ArticleDetailView.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 12/01/22.
//

import UIKit

class ArticleDetailView: UIView {

    private enum Constants {
        static let insetPadding = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 18.0, right: 16.0)
        static let textSpacing = 10.0
        static let titleFontSize = 14.0
        static let descriptionFontSize = 12.0
    }
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let authorsLabel = UILabel()
    private let tagsLabel = UILabel()

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with report: Report) {
        titleLabel.text = report.title
        descriptionLabel.text = report.description

        let authors = report.authors?
            .compactMap { $0.name }
            .joined(separator: ",")
        authorsLabel.text = "Authors: " + (authors ?? "-")

        let tags = report.tags?.joined(separator: ",")
        tagsLabel.text = "Tags: " + (tags ?? "-")
    }

    // MARK: - Private Methods

    private func commonInit() {
        setupUI()
        setupStackView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupTagsLabel()
    }

    private func setupUI() {
        addSubview(stackView)
        stackView.constraintToMatch(view: self)
    }

    private func setupStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(tagsLabel)
        stackView.addArrangedSubview(authorsLabel)

        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = Constants.textSpacing
    }

    private func setupTitleLabel() {
        titleLabel.textColor = ColorPalette.text
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
    }

    private func setupDescriptionLabel() {
        descriptionLabel.textColor = ColorPalette.text
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
    }

    private func setupAuthorsLabel() {
        authorsLabel.textColor = ColorPalette.text
        authorsLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        authorsLabel.numberOfLines = 1
    }

    private func setupTagsLabel() {
        tagsLabel.textColor = ColorPalette.text
        tagsLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        tagsLabel.numberOfLines = 1
    }
}
