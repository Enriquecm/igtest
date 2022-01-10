//
//  NetworkTask.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

/// Holds all the context needed to perform a network request
class NetworkTask {

    // MARK: Properties

    let url: URL
    let method: HTTPMethod
    let headerFields: [String: String]
    let timeout: TimeInterval
    let qosClass: DispatchQoS.QoSClass

    // MARK: Lifecycle

    /// Constructor for `NetworkTask` with default parameters
    ///
    /// - Parameters:
    ///   - url: Valid `URL` with just schema, domain and base path (e.g. https://domain.com/path/subpath).
    ///   - method: `HTTPMethod` for request, this contains the payload info. Defaults to `.get(.empty)`.
    ///   - headerFields: Header fields to be injected into request. Defaults to `[:]`.
    ///   - timeout: Optional value for the `URLRequest`'s timeoutInterval. Defaults to `60`.
    ///   - qosClass: Dispatch queue class where the request will do its work (e.g. encoding and decoding processing). Defaults to `.userInitiated`.
    init(
        url: URL,
        method: HTTPMethod = .get(.empty),
        headerFields: [String: String] = [:],
        timeout: TimeInterval? = nil,
        qosClass: DispatchQoS.QoSClass = .userInitiated
    ) {
        self.url = url
        self.method = method
        self.headerFields = headerFields

        self.timeout = timeout ?? NetworkConstants.timeoutInterval
        self.qosClass = qosClass
    }

    // MARK: Methods

    func urlRequest() throws -> URLRequest {
        let url: URL
        let body: Data?
        let contentTypeHeader: String?

        switch self.method {
        case .get(let type), .delete(let type):
            url = try encodeQueryString(forType: type)
            body = nil
            contentTypeHeader = nil

        case .post(let type), .put(let type):
            (url, body, contentTypeHeader) = try self.encodeBody(forType: type)
        }

        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue

        self.headerFields.forEach { request.setValue($0.1, forHTTPHeaderField: $0.0) }

        if let body = body {
            request.httpBody = body
            request.setValue(contentTypeHeader, forHTTPHeaderField: NetworkConstants.contentTypeKey)
        }

        return request
    }
}

// MARK: Private

private extension NetworkTask {
    func encodeQueryString(forType type: QueryStringPayloadType) throws -> URL {
        let url: URL
        switch type {
        case .empty:
            url = self.url
        case .queryString(let parameters):
            url = try urlWith(parameters: parameters)
        }
        return url
    }

    func encodeBody(forType type: BodyPayloadType) throws -> (URL, Data?, String?) {
        let url: URL
        let body: Data?
        let contentTypeHeader: String?

        switch type {
        case .empty:
            url = self.url
            body = nil
            contentTypeHeader = nil

        case .queryString(let parameters):
            url = try self.urlWith(parameters: parameters)
            body = nil
            contentTypeHeader = nil

        case .body(let encodable):
            url = self.url
            (body, contentTypeHeader) = try self.bodyData(encodable: encodable)

        case .queryStringAndBody(let parameters, let encodable):
            url = try self.urlWith(parameters: parameters)
            (body, contentTypeHeader) = try self.bodyData(encodable: encodable)
        }

        return (url, body, contentTypeHeader)
    }

    func urlWith(parameters: [String: String]) throws -> URL {
        guard var urlComponents = URLComponents(url: self.url, resolvingAgainstBaseURL: false) else {
            throw NetworkingError.invalidURL
        }

        if parameters.isEmpty == false {
            var queryItems = urlComponents.queryItems ?? []
            queryItems.append(contentsOf: parameters.map { URLQueryItem(name: $0, value: $1) })
            urlComponents.queryItems = queryItems

            if let url = urlComponents.url {
                return url
            } else {
                throw NetworkingError.queryStringInvalidatesURL
            }
        } else {
            return url
        }
    }

    func bodyData(encodable: Encodable) throws -> (Data?, String?) {
        // TODO: Encode data
        throw NetworkingError.invalidEncodable
    }
}
