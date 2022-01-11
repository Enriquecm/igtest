//
//  NetworkingDataTaskTests.swift
//  IGTestTests
//
//  Created by Enrique Melgarejo on 11/01/22.
//

import XCTest
@testable import IGTest

class NetworkingDataTaskTests: XCTestCase {

    private enum Constants {
        static let url = URL(string: "https://local.domain/path")!
        static let urlWithQueryString = URL(string: "https://local.domain/path?key=value")!

        static let jsonHeaderKey = "Content-Type"
        static let jsonHeaderValue = "application/json"

        static let queryStringParameters = ["key": "value"]
    }

    // MARK: - GET

    func testTaskEmptyGET() {

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(url: Constants.url) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.url)
        XCTAssertEqual(task.method, HTTPMethod.get(.empty))
        XCTAssertEqual(task.headerFields, [:])

        let request = try? task.urlRequest()

        XCTAssertEqual(request?.httpMethod, HTTPMethod.get(.empty).rawValue)
        XCTAssertEqual(request?.url, Constants.url)
        XCTAssertEqual(request?.httpBody, nil)
        XCTAssertEqual(request?.allHTTPHeaderFields, [:])
    }

    func testTaskQueryStringGET() {

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(
            url: Constants.url,
            method: .get(.queryString(Constants.queryStringParameters))
        ) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.url)
        XCTAssertEqual(task.method, HTTPMethod.get(.queryString([:])))
        XCTAssertEqual(task.headerFields, [:])

        let request = try? task.urlRequest()

        XCTAssertEqual(request?.httpMethod, HTTPMethod.get(.empty).rawValue)
        XCTAssertEqual(request?.url, Constants.urlWithQueryString)
        XCTAssertEqual(request?.httpBody, nil)
    }

    func testAcceptHeaderPrecedence() {

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(
            url: Constants.url,
            method: .get(.queryString(Constants.queryStringParameters)),
            headerFields: [Constants.jsonHeaderKey : Constants.jsonHeaderValue]
        ) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.url)
        XCTAssertEqual(task.method, HTTPMethod.get(.queryString([:])))
        XCTAssertEqual(task.headerFields[Constants.jsonHeaderKey], Constants.jsonHeaderValue)

        let request = try? task.urlRequest()

        XCTAssertEqual(request?.httpMethod, HTTPMethod.get(.empty).rawValue)
        XCTAssertEqual(request?.url, Constants.urlWithQueryString)
        XCTAssertEqual(request?.httpBody, nil)
        XCTAssertEqual(request?.allHTTPHeaderFields?[Constants.jsonHeaderKey], Constants.jsonHeaderValue)
    }

    func testTaskExistingQueryStringWithQueryStringGET() {

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(
            url: Constants.urlWithQueryString,
            method: .get(.queryString(["key1": "value1"]))
        ) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.urlWithQueryString)
        XCTAssertEqual(task.method, HTTPMethod.get(.queryString([:])))
        XCTAssertEqual(task.headerFields, [:])

        let request = try? task.urlRequest()

        XCTAssertEqual(request?.httpMethod, HTTPMethod.get(.empty).rawValue)
        XCTAssertEqual(request?.url, URL(string: "https://local.domain/path?key=value&key1=value1"))
        XCTAssertEqual(request?.httpBody, nil)
    }

    // MARK: - POST

    func testTaskEmptyPOST() {

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(
            url: Constants.url,
            method: .post(.empty)
        ) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.url)
        XCTAssertEqual(task.method, HTTPMethod.post(.empty))
        XCTAssertEqual(task.headerFields, [:])

        let request = try? task.urlRequest()

        XCTAssertEqual(request?.httpMethod, HTTPMethod.post(.empty).rawValue)
        XCTAssertEqual(request?.url, Constants.url)
        XCTAssertEqual(request?.httpBody, nil)
    }

    func testTaskQueryStringPOST() {

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(
            url: Constants.url,
            method: .post(.queryString(Constants.queryStringParameters))
        ) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.url)
        XCTAssertEqual(task.method, HTTPMethod.post(.queryString([:])))
        XCTAssertEqual(task.headerFields, [:])

        let request = try? task.urlRequest()

        XCTAssertEqual(request?.httpMethod, HTTPMethod.post(.empty).rawValue)
        XCTAssertEqual(request?.url, Constants.urlWithQueryString)
        XCTAssertEqual(request?.httpBody, nil)
    }

    func testTaskBodyPOST() {

        let encodable = EncodableStub()

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(
            url: Constants.url,
            method: .post(.body(encodable))
        ) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.url)
        XCTAssertEqual(task.method, HTTPMethod.post(.body(encodable)))
        XCTAssertEqual(task.headerFields, [:])

        let request = try? task.urlRequest()

        let encoded = try? JSONEncoder().encode(encodable)
        XCTAssertEqual(request?.httpMethod, HTTPMethod.post(.empty).rawValue)
        XCTAssertEqual(request?.url, Constants.url)
        XCTAssertNotNil(request?.httpBody)
        XCTAssertEqual(request?.httpBody, encoded)
    }

    func testTaskQueryStringBodyPOST() {

        let encodable = EncodableStub()

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(
            url: Constants.url,
            method: .post(.queryStringAndBody(Constants.queryStringParameters, encodable))
        ) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.url)
        XCTAssertEqual(task.method, HTTPMethod.post(.queryStringAndBody([:], encodable)))
        XCTAssertEqual(task.headerFields, [:])

        let request = try? task.urlRequest()

        let encoded = try? JSONEncoder().encode(encodable)
        XCTAssertEqual(request?.httpMethod, HTTPMethod.post(.empty).rawValue)
        XCTAssertEqual(request?.url, Constants.urlWithQueryString)
        XCTAssertNotNil(request?.httpBody)
        XCTAssertEqual(request?.httpBody, encoded)
    }

    // MARK: - PUT

    func testTaskEmptyPUT() {

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(
            url: Constants.url,
            method: .put(.empty)
        ) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.url)
        XCTAssertEqual(task.method, HTTPMethod.put(.empty))
        XCTAssertEqual(task.headerFields, [:])

        let request = try? task.urlRequest()

        XCTAssertEqual(request?.httpMethod, HTTPMethod.put(.empty).rawValue)
        XCTAssertEqual(request?.url, Constants.url)
        XCTAssertEqual(request?.httpBody, nil)
    }

    func testTaskQueryStringPUT() {

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(
            url: Constants.url,
            method: .put(.queryString(Constants.queryStringParameters))
        ) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.url)
        XCTAssertEqual(task.method, HTTPMethod.put(.queryString([:])))
        XCTAssertEqual(task.headerFields, [:])

        let request = try? task.urlRequest()

        XCTAssertEqual(request?.httpMethod, HTTPMethod.put(.empty).rawValue)
        XCTAssertEqual(request?.url, Constants.urlWithQueryString)
        XCTAssertEqual(request?.httpBody, nil)
    }

    func testTaskBodyPUT() {

        let encodable = EncodableStub()

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(
            url: Constants.url,
            method: .put(.body(encodable))
        ) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.url)
        XCTAssertEqual(task.method, HTTPMethod.put(.body(encodable)))
        XCTAssertEqual(task.headerFields, [:])

        let request = try? task.urlRequest()

        let encoded = try? JSONEncoder().encode(encodable)
        XCTAssertEqual(request?.httpMethod, HTTPMethod.put(.empty).rawValue)
        XCTAssertEqual(request?.url, Constants.url)
        XCTAssertNotNil(request?.httpBody)
        XCTAssertEqual(request?.httpBody, encoded)
    }

    func testTaskQueryStringBodyPUT() {

        let encodable = EncodableStub()

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(
            url: Constants.url,
            method: .put(.queryStringAndBody(Constants.queryStringParameters, encodable))
        ) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.url)
        XCTAssertEqual(task.method, HTTPMethod.put(.queryStringAndBody([:], encodable)))
        XCTAssertEqual(task.headerFields, [:])

        let request = try? task.urlRequest()

        let encoded = try? JSONEncoder().encode(encodable)
        XCTAssertEqual(request?.httpMethod, HTTPMethod.put(.empty).rawValue)
        XCTAssertEqual(request?.url, Constants.urlWithQueryString)
        XCTAssertNotNil(request?.httpBody)
        XCTAssertEqual(request?.httpBody, encoded)
    }

    // MARK: - DELETE

    func testTaskEmptyDELETE() {

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(
            url: Constants.url,
            method: .delete(.empty)
        ) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.url)
        XCTAssertEqual(task.method, HTTPMethod.delete(.empty))
        XCTAssertEqual(task.headerFields, [:])

        let request = try? task.urlRequest()

        XCTAssertEqual(request?.httpMethod, HTTPMethod.delete(.empty).rawValue)
        XCTAssertEqual(request?.url, Constants.url)
        XCTAssertEqual(request?.httpBody, nil)
    }

    func testTaskQueryStringDELETE() {

        let task = NetworkDataTask<DiscardableResult, DiscardableResult>(
            url: Constants.url,
            method: .delete(.queryString(Constants.queryStringParameters))
        ) { _, _, _ in }

        XCTAssertEqual(task.url, Constants.url)
        XCTAssertEqual(task.method, HTTPMethod.delete(.queryString([:])))
        XCTAssertEqual(task.headerFields, [:])

        let request = try? task.urlRequest()

        XCTAssertEqual(request?.httpMethod, HTTPMethod.delete(.empty).rawValue)
        XCTAssertEqual(request?.url, Constants.urlWithQueryString)
        XCTAssertEqual(request?.httpBody, nil)
    }
}
