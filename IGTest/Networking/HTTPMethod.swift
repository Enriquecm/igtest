//
//  HTTPMethod.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

/// Enum with associated values for `HTTPMethod`s with query string only payloads.
///
/// - empty: No parameters sent.
/// - queryString: Query string payload type, with dictionary as associated values.
enum QueryStringPayloadType: Equatable {
    case empty
    case queryString([String: String])
}

/// Enum with associated values for `HTTPMethod`'s with body payloads.
///
/// - empty: No parameters sent.
/// - queryString: Query string payload type, with dictionary as associated values.
/// - body: Body payload type, with `Encodable` as associated value.
/// - queryStringAndBody: Query string and body payload type, with dictionary and `Encodable` as associated values.
enum BodyPayloadType: Equatable {
    case empty
    case queryString([String: String])
    case body(Encodable)
    case queryStringAndBody([String: String], Encodable)

    static func == (lhs: BodyPayloadType, rhs: BodyPayloadType) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty):
            return true
        case (.queryString, .queryString):
            return true
        case (.body, .body):
            return true
        case (.queryStringAndBody, .queryStringAndBody):
            return true
        default:
            return false
        }
    }
}

/// Supported HTTP methods enum with payload as associated values
/// - get: GET, takes `QueryStringPayloadType` as payload.
/// - post: POST, takes `BodyPayloadType` as payload.
/// - put: PUT, takes `BodyPayloadType` as payload.
/// - delete: DELETE, takes `QueryStringPayloadType` as payload.
enum HTTPMethod: Equatable {
    case get(QueryStringPayloadType)
    case post(BodyPayloadType)
    case put(BodyPayloadType)
    case delete(QueryStringPayloadType)
}

extension HTTPMethod: RawRepresentable {
    typealias RawValue = String

    public init?(rawValue: RawValue) {
        switch rawValue {
        case "GET":
            self = .get(.empty)
        case "POST":
            self = .post(.empty)
        case "PUT":
            self = .put(.empty)
        case "DELETE":
            self = .delete(.empty)
        default:
            return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
}
