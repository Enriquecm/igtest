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
