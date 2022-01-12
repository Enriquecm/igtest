//
//  DailyFxAPITests.swift
//  IGTestTests
//
//  Created by Enrique Melgarejo on 11/01/22.
//

import XCTest
@testable import IGTest

class DailyFxAPITests: XCTestCase {

    private enum Constants {
        static let url = URL(string: "https://local.domain/path")!
    }

    private var api: DailyFxAPI?
    private let config = Config(baseUrl: Constants.url)

    override func setUp() {
        let urlConfig = URLSessionConfiguration.ephemeral
        urlConfig.protocolClasses = [MockURLProtocol.self]

        let session = URLSession(configuration: urlConfig)
        let networking = Networking(session: session, decoder: JSONDecoder())

        api = DailyFxAPI(config: config, networking: networking)
    }

    func testInit() {
        XCTAssertNotNil(api)
        XCTAssertNotNil(api?.networking)
        XCTAssertNotNil(api?.configuration)
        XCTAssertEqual(api?.configuration.baseUrl, config.baseUrl)
    }

    func testRequestDashboard() throws {

        let expectedData = Dashboard(
            topNews: [],
            dailyBriefings: nil,
            technicalAnalysis: [],
            specialReport: []
        )

        let mockData = try JSONEncoder().encode(expectedData)
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }

        let expectation = XCTestExpectation(description: "testRequestDashboard")

        api?.requestDashboard { result in
            switch result {
            case .success(let model):
                XCTAssertEqual(model, expectedData)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testRequestDashboardWithError() throws {

        let expectedError = NetworkError<DiscardableResult>(
            error: .connectionError(errorMessage: NetworkingError.invalidURL.localizedDescription)
        )

        MockURLProtocol.requestHandler = { request in
            throw NetworkingError.invalidURL
        }

        let expectation = XCTestExpectation(description: "testRequestDashboardWithError")

        api?.requestDashboard { result in
            switch result {
            case .success:
                XCTFail("Request dashboard should return error")
            case .failure(let error):
                XCTAssertEqual(error, expectedError)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    // MARK: - Markets
    func testRequestMarkets() throws {

        let expectedData = Markets(currencies: [], commodities: [], indices: [])

        let mockData = try JSONEncoder().encode(expectedData)
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }

        let expectation = XCTestExpectation(description: "testRequestMarkets")

        api?.requestMarkets { result in
            switch result {
            case .success(let model):
                XCTAssertEqual(model, expectedData)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testRequestMarketsWithError() throws {

        let expectedError = NetworkError<DiscardableResult>(
            error: .connectionError(errorMessage: NetworkingError.invalidURL.localizedDescription)
        )

        MockURLProtocol.requestHandler = { request in
            throw NetworkingError.invalidURL
        }

        let expectation = XCTestExpectation(description: "testRequestMarketsWithError")

        api?.requestMarkets { result in
            switch result {
            case .success:
                XCTFail("Request markets should return error")
            case .failure(let error):
                XCTAssertEqual(error, expectedError)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
}
