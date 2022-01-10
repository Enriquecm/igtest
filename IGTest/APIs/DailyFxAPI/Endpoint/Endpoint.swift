//
//  Endpoint.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

/// Use this protocol to determine all the main properties to build the final url of a specific endpoint.
///
/// - Parameters:
///     - apiVersion: Version of the api
///     - path: Specific url path
///     - method: `HTTPMethod` for request, this contains the payload info. Defaults to `.get(.empty)`.
///     - headers: Header fields to be injected into request.
///

protocol Endpoint {
    var apiVersion: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }

    func url(for configuration: Config) -> URL
}

extension Endpoint {
    var apiVersion: String { "v1" }

    var apiName: String { "api" }

    var headers: [String: String] { [:] }

    func url(for configuration: Config) -> URL {
        return configuration.baseUrl
            .appendingPathComponent(self.apiName)
            .appendingPathComponent(self.apiVersion)
            .appendingPathComponent(self.path)
    }
}
