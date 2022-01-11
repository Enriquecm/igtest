//
//  NetworkingTests.swift
//  IGTestTests
//
//  Created by Enrique Melgarejo on 11/01/22.
//

import XCTest
@testable import IGTest

class NetworkingTests: XCTestCase {

    private enum Constants {
        static let url = URL(string: "https://local.domain/path")!
    }

    private var session: URLSession?

    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
    }

    func testRequest() throws {
        guard let session = session else {
            XCTFail("URLSession should be initialized.")
            return
        }

        let sampleData = EncodableStub()
        let mockData = try JSONEncoder().encode(sampleData)

        let networking = Networking(session: session)
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }

        let expectation = XCTestExpectation(description: "testRequest")

        let task = NetworkDataTask<EncodableStub, DiscardableResult>(url: Constants.url) { request, response, result in

            switch result {
            case .success(let model):
                XCTAssertEqual(model, sampleData)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }

        networking.request(task: task)

        wait(for: [expectation], timeout: 1)
    }
}
