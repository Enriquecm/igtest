//
//  IGError.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 11/01/22.
//

import Foundation

protocol IGError {
    var message: String { get }
}

enum PlatformError: IGError, Error {
    case generic
    case noNetwork
    case notFound

    var message: String {
        return self.localizedDescription
    }
}

enum BusinessError: IGError, Error {
    case unknown
    case dashboardNotFound
    case marketsNotFound
    case networkError(NetworkingError)

    static func map<T>(_ networkError: NetworkError<T>) -> Self {
        let networkingError = networkError.error as NetworkingError
        return BusinessError.networkError(networkingError)
    }

    static func map(_ error: Error) -> Self {
        return BusinessError.unknown
    }

    var message: String {
        return self.localizedDescription
    }
}
