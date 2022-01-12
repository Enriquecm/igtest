//
//  ArticlesViewModelTests.swift
//  IGTestTests
//
//  Created by Enrique Melgarejo on 12/01/22.
//

import Combine
import XCTest
@testable import IGTest

class ArticlesViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        cancellables.forEach { $0.cancel() }
    }

    func testViewModelCoordinator() {
        let expectedModel = Report.mock

        let coordinatorMock = ArticlesCoordinatorMock { report in
            XCTAssertEqual(report, expectedModel)
        }

        let viewModel = ArticlesViewModel(coordinator: coordinatorMock, dataSource: .mock)
        viewModel.didSelect(report: expectedModel)
    }

    func testWithMockDataSource() {
        let coordinatorMock = ArticlesCoordinatorMock { _ in }
        let viewModel = ArticlesViewModel(coordinator: coordinatorMock, dataSource: .mock)

        viewModel.fetchDashboard()
            .sink { completion in
                switch completion {
                case .failure:
                    XCTFail("Mock Data should not fail")
                case .finished:
                    break
                }
            } receiveValue: { reportSections in
                XCTAssertEqual(reportSections.count, 3)
                XCTAssertEqual(reportSections[0].title, "Top News")
                XCTAssertEqual(reportSections[0].reports.count, 2)
                XCTAssertEqual(reportSections[1].title, "Technical Analysis")
                XCTAssertEqual(reportSections[1].reports.count, 1)
                XCTAssertEqual(reportSections[2].title, "Special")
                XCTAssertEqual(reportSections[2].reports.count, 3)
            }.store(in: &cancellables)
    }

    func testWithFailedDataSource() {
        let expectedError = BusinessError.unknown

        let coordinatorMock = ArticlesCoordinatorMock { _ in }
        let viewModel = ArticlesViewModel(coordinator: coordinatorMock, dataSource: .failed)

        viewModel.fetchDashboard()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error, expectedError)
                case .finished:
                    break
                }
            } receiveValue: { reportSections in
                XCTFail("Mock Data should fail")
            }.store(in: &cancellables)
    }
}
