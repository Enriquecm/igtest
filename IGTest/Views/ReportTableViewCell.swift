//
//  ReportTableViewCell.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 11/01/22.
//

import UIKit

class ReportTableViewCell: UITableViewCell, CellProtocol {
    
    private enum Constants {
        static let insetPadding = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 18.0, right: 16.0)
        static let textSpacing = 10.0
        static let titleFontSize = 14.0
        static let descriptionFontSize = 12.0
    }

    // MARK: - UI Elements

    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
    }

    func setup(with report: Report) {
        titleLabel.text = report.title
        descriptionLabel.text = report.description
    }

    // MARK: - Private methods
    private func commonInit() {
        setupUI()
        setupStackView()
        setupTitleLabel()
        setupDescriptionLabel()
    }

    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(stackView)
        stackView.constraintToMatch(view: self.contentView, inset: Constants.insetPadding)
    }

    private func setupStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)

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
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        titleLabel.setContentHuggingPriority(UILayoutPriority(750), for: .vertical)
    }

    private func setupDescriptionLabel() {
        descriptionLabel.textColor = ColorPalette.text
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(800), for: .vertical)
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(999), for: .vertical)
    }
}
