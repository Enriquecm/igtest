//
//  TabCoordinator.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

protocol TabCoordinatorProtocol: AnyObject { }

class TabCoordinator: Coordinator, TabCoordinatorProtocol {
    private let navigationController: UINavigationController
    private let api: DailyFxAPIProtocol

    var rootViewController: UIViewController {
        return navigationController
    }
    
    var childCoordinators = [Coordinator]()

    init(_ navigationController: UINavigationController, api: DailyFxAPIProtocol) {
        self.navigationController = navigationController
        self.api = api
    }

    func start() {
        setupUI()

        let tabBarController = TabBarController(coordinator: self)

        // Dashboard
        let dashboardCoordinator = DashboardCoordinator(navigationController, api: api)
        dashboardCoordinator.start()

        let dashboardRootViewController = dashboardCoordinator.rootViewController
        dashboardRootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)

        // Markets
        let marketsNavigationController = UINavigationController()
        marketsNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)

        let marketsCoordinator = MarketsCoordinator(marketsNavigationController, api: api)
        marketsCoordinator.start()

        tabBarController.viewControllers = [dashboardRootViewController,
                                            marketsNavigationController]

        navigationController.viewControllers = [tabBarController]

        childCoordinators.append(dashboardCoordinator)
        childCoordinators.append(marketsCoordinator)
    }

    private func setupUI() {
        navigationController.isNavigationBarHidden = true
    }
}
