//
//  NetworkingError.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

enum NetworkingError: Error {
    case `default`
    
    // Request Error
    case invalidURL
    case queryStringInvalidatesURL
    case invalidEncodable

    // Response Error
    case invalidResponse
    case badData(response: HTTPURLResponse)
    case invalidStatusCode(response: HTTPURLResponse)
    case badURL(response: HTTPURLResponse)
}
