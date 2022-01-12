//
//  MarketsViewModelTests.swift
//  IGTestTests
//
//  Created by Enrique Melgarejo on 12/01/22.
//

import Combine
import XCTest
@testable import IGTest

class MarketsViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        cancellables.forEach { $0.cancel() }
    }

    func testWithMockDataSource() {
        let coordinator = MarketsCoordinatorMock()
        let viewModel = MarketsViewModel(coordinator: coordinator, dataSource: .mock)
        viewModel.fetchMarkets()
            .sink { completion in
                switch completion {
                case .failure:
                    XCTFail("Mock Data should not fail")
                case .finished:
                    break
                }
            } receiveValue: { marketSections in
                XCTAssertEqual(marketSections.count, 3)
                XCTAssertEqual(marketSections[0].title, "Currencies")
                XCTAssertEqual(marketSections[0].markets.count, 2)
                XCTAssertEqual(marketSections[1].title, "Commodities")
                XCTAssertEqual(marketSections[1].markets.count, 1)
                XCTAssertEqual(marketSections[2].title, "Indices")
                XCTAssertEqual(marketSections[2].markets.count, 3)
            }.store(in: &cancellables)
    }

    func testWithFailedDataSource() {
        let expectedError = BusinessError.unknown

        let coordinator = MarketsCoordinatorMock()
        let viewModel = MarketsViewModel(coordinator: coordinator, dataSource: .failed)

        viewModel.fetchMarkets()
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
