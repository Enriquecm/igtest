//
//  DashboardEndpoint.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 10/01/22.
//

import Foundation

struct DashboardEndpoint: Endpoint {
    var path: String
    var method: HTTPMethod
}

extension DashboardEndpoint {
    static func getDashboard() -> DashboardEndpoint {
        DashboardEndpoint(path: "dashboard", method: .get(.empty))
    }
}
