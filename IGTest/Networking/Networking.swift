//
//  Networking.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

/// Main class to perform network requests
struct Networking {
    /// Private session for networking requests
    private let session: URLSession
    private let decoder: JSONDecoder
    
    /// This is the sole constructor of this class, it takes URLSession as parameter
    ///
    /// - Parameters:
    ///   - session: Default value uses URLSessionConfiguration.default to create an URLSession
    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.default),
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    /// Use this method to perform the network request.
    /// - `T` stands for successful model to be parsed from the body, implements `Decodable`
    /// - `E` stands for error model to be parsed from the body, implements `Decodable`
    /// - Use `DiscardableResult` if no model should be parsed from body.
    ///
    /// - Parameter task: Object containg all the context to perform a network request
    func request<T, E>(task: NetworkDataTask<T, E>) {
        let queue = DispatchQueue.global(qos: task.qosClass)

        queue.async {
            guard let request = try? task.urlRequest() else {
                let error = NetworkingError.invalidURL
                task.completion(nil, nil, .failure(NetworkError(error: error)))
                return
            }

            let dataTask = self.dataTask(with: request, queue: queue, task: task)
            task.dataTask = dataTask
            dataTask.resume()
        }
    }
}

private extension Networking {

    func dataTask<T, E>(
        with request: URLRequest,
        queue: DispatchQueue,
        task: NetworkDataTask<T, E>
    ) -> URLSessionDataTask {
        let dataTask = self.session.dataTask(with: request) { data, response, error in
            queue.async {
                let result: Result<T, NetworkError<E>>

                if let connectionError = error {
                    // Doesn't mean http error, it's a connection error most likely
                    result = .failure(NetworkError(error: .connectionError(errorMessage: connectionError.localizedDescription)))
                } else {
                    // No connection error, we might have an http error though
                    if let validResponse = response as? HTTPURLResponse,
                        NetworkConstants.successResponseRange ~= validResponse.statusCode {

                        // Valid http response
                        if let data = data, let object = try? decoder.decode(T.self, from: data) {
                            result = .success(object)
                        } else {
                            result = .failure(NetworkError(error: NetworkingError.badData(response: validResponse)))
                        }
                    } else if let validResponse = response as? HTTPURLResponse {
                        let errorObject: E?
                        if E.self is DiscardableResult.Type {
                            errorObject = nil
                        } else if let data = data, let parsedObject = try? decoder.decode(E.self, from: data) {
                            errorObject = parsedObject
                        } else {
                            errorObject = nil
                        }

                        let networkingError = NetworkingError.invalidStatusCode(response: validResponse)
                        result = .failure(NetworkError(error: networkingError, object: errorObject))
                    } else {
                        // This should never happen, not having an error and a invalid response
                        result = .failure(NetworkError(error: NetworkingError.invalidResponse))
                    }
                }

                let response = response as? HTTPURLResponse
                task.completion(request, response, result)
            }
        }
        return dataTask
    }
}
