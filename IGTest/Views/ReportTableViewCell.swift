//
//  ReportTableViewCell.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 11/01/22.
//

import UIKit

class ReportTableViewCell: UITableViewCell, CellProtocol {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()

    }

    private func setupUI() {
        contentView.backgroundColor = .clear
    }

    func setup(with report: Report) {
    }

}
