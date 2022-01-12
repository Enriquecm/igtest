//
//  CellProtocol.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 11/01/22.
//

import UIKit

protocol CellProtocol {
    static var identifier: String { get }
}

extension CellProtocol where Self: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension CellProtocol where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension CellProtocol where Self: UITableViewHeaderFooterView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension CellProtocol where Self: UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
