//
//  ArticlesCoordinatorMock.swift
//  IGTestTests
//
//  Created by Enrique Melgarejo on 12/01/22.
//

import Foundation
@testable import IGTest

class ArticlesCoordinatorMock: ArticlesCoordinatorProtocol {
    var didSelectReport: ((Report) -> Void)

    init(didSelectReport: @escaping ((Report) -> Void)) {
        self.didSelectReport = didSelectReport
    }

    func didSelect(report: Report) {
        didSelectReport(report)
    }
}
