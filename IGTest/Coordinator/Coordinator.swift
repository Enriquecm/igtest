//
//  Coordinator.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

/// Protocol for coordinating the application flow.
protocol Coordinator {
    /// Represents the coordinator's root view controller
    /// - Note: Each coordinator has one assigned to it.
    var rootViewController: UIViewController { get }

    /// An Array of all child coordinators.
    /// - Note: Normally it contains only one child coordinator
    var childCoordinators: [Coordinator] { get set }

    /// Start the flow.
    func start()
}
