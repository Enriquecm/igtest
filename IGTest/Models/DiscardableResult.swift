//
//  DiscardableResult.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

/// This struct should be used when no type is expected or it should be ignored
public struct DiscardableResult {
    init() { }
}

extension DiscardableResult: Decodable, Equatable { }
