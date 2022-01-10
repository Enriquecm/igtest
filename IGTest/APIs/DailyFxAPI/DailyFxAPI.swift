//
//  DailyFxAPI.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Combine
import Foundation

protocol DailyFxAPIProtocol {
    @discardableResult
    func request<T: Decodable, E: Decodable>(
        _ endpoint: Endpoint,
        then completion: @escaping (HTTPURLResponse?, Result<T, NetworkError<E>>) -> Void
    ) -> NetworkDataTask<T, E>
}

struct DailyFxAPI {
    let configuration: Config
    let networking: Networking

    /// Initializer of the class
    ///
    /// - Parameters:
    ///   - config: Config object with all configuration needed
    ///   - networking: Networking object configured
    init(config: Config, networking: Networking) {
        self.configuration = config
        self.networking = networking
    }
}

extension DailyFxAPI: DailyFxAPIProtocol {
    @discardableResult
    func request<T: Decodable, E: Decodable>(
        _ endpoint: Endpoint,
        then completion: @escaping (HTTPURLResponse?, Result<T, NetworkError<E>>) -> Void
    ) -> NetworkDataTask<T, E> {

        let task = NetworkDataTask<T, E>(
            url: endpoint.url(for: self.configuration),
            method: endpoint.method,
            headerFields: endpoint.headers
        ) { _, response, result in

            completion(response, result)
        }

        self.networking.request(task: task)

        return task
    }
}
