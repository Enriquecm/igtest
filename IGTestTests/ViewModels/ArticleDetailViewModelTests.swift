//
//  ArticleDetailViewModelTests.swift
//  IGTestTests
//
//  Created by Enrique Melgarejo on 12/01/22.
//

import XCTest
@testable import IGTest

class ArticleDetailViewModelTests: XCTestCase {

    func testInitialization() {
        let expectedReport = Report.mock

        let coordinator = ArticleDetailCoordinatorMock()
        let viewModel = ArticleDetailViewModel(coordinator: coordinator, report: expectedReport)

        XCTAssertEqual(expectedReport, viewModel.report)
    }
}

