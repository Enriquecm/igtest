//
//  NetworkDataTask.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

/// Specialization of NetworkTask for `URLSessionDataTask`
class NetworkDataTask<T, E>: NetworkTask where T: Decodable, E: Decodable {

    /// Completion alias for when the task finishes
    ///
    /// - Parameters:
    ///   - request: `URLConnection`'s currentRequest that was performed
    ///   - response: `HTTPURLResponse` from the performed request
    ///   - result: `Result` enum, success with expected model parsed or `NetworkError` model in case of failure
    typealias NetworkDataTaskCompletion = (
        _ request: URLRequest?,
        _ response: HTTPURLResponse?,
        _ result: Result<T, NetworkError<E>>
    ) -> Void

    // MARK: Properties

    let completion: NetworkDataTaskCompletion

    /// As soon the `Networking` creates an `URLSessionTask` for this task, it gets assigned here
    var dataTask: URLSessionDataTask?

    // MARK: Lifecycle

    /// Constructor for `NetworkDataTask` with default parameters
    ///
    /// - Parameters:
    ///   - url: Valid `URL` with just schema, domain and base path (e.g. https://domain.top/path/subpath).
    ///   - method: `HTTPMethod` for request, this contains the payload info. Defaults to `.get(.empty)`.
    ///   - headerFields: Header fields to be injected into request. Defaults to `[:]`.
    ///   - timeout: Optional value for the `URLRequest`'s timeoutInterval. Defaults to `60`.
    ///   - qosClass: Dispatch queue class where the request will do its work (e.g. encoding and decoding processing). Defaults to `.userInitiated`.
    ///   - completion: Closure for when the task finishes. It executes in whatever QoSClass passed as argument.
    init(
        url: URL,
        method: HTTPMethod = .get(.empty),
        headerFields: [String: String] = [:],
        timeout: TimeInterval? = nil,
        qosClass: DispatchQoS.QoSClass = .userInitiated,
        completion: @escaping NetworkDataTaskCompletion
    ) {
        self.completion = completion
        super.init(url: url,
                   method: method,
                   headerFields: headerFields,
                   timeout: timeout,
                   qosClass: qosClass)
    }
}
