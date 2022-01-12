//
//  ReportTableViewCell.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 11/01/22.
//

import Combine
import UIKit

class ReportTableViewCell: UITableViewCell, CellProtocol {
    
    private enum Constants {
        static let insetPadding = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 18.0, right: 16.0)
        static let contentSpacing = 10.0
        static let textSpacing = 10.0
        static let titleFontSize = 14.0
        static let descriptionFontSize = 12.0
    }

    private var imageCancellable: AnyCancellable?

    // MARK: - UI Elements

    private let stackView = UIStackView()
    private let headlineImageView = UIImageView()
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
        imageCancellable?.cancel()
        headlineImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }

    func setup(with report: Report) {
        if let url = URL(string: report.headlineImageUrl ?? "") {
            imageCancellable = headlineImageView.loadImage(with: url)
        }

        titleLabel.text = report.title
        descriptionLabel.text = report.description
    }

    // MARK: - Private methods
    private func commonInit() {
        setupUI()
        setupStackView()
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }

    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(stackView)
        stackView.constraintToMatch(view: self.contentView, inset: Constants.insetPadding)

        NSLayoutConstraint.activate([
            headlineImageView.heightAnchor.constraint(equalToConstant: 120),
            headlineImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func setupStackView() {
        stackView.addArrangedSubview(headlineImageView)
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = Constants.contentSpacing

        let textsStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        textsStackView.distribution = .fill
        textsStackView.axis = .vertical
        textsStackView.alignment = .fill
        textsStackView.spacing = Constants.textSpacing
        stackView.addArrangedSubview(textsStackView)
    }

    private func setupImageView() {
        headlineImageView.clipsToBounds = true
        headlineImageView.contentMode = .scaleAspectFill
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

private extension UIImageView {
    func loadImage(with url: URL) -> AnyCancellable {
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}
