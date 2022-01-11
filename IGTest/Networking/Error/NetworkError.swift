//
//  NetworkError.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

struct NetworkError<T>: Error where T: Decodable {
    public let error: Error
    public let object: T?

    init(error: Error, object: T? = nil) {
        self.error = error
        self.object = object
    }
}

extension NetworkError: Equatable where T: Equatable {
    static func == (lhs: NetworkError<T>, rhs: NetworkError<T>) -> Bool {
        let lhserror = lhs.error as NSError
        let rhserror = rhs.error as NSError

        let nserror = lhserror.domain == rhserror.domain && lhserror.code == rhserror.code
        let object = lhs.object == rhs.object

        return nserror && object
    }
}
