//
//  DashboardCoordinator.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

protocol DashboardCoordinatorProtocol: AnyObject {
    func didSelectButton()
}

class DashboardCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let api: DailyFxAPIProtocol

    private lazy var splitViewController: UISplitViewController = {
        return DashboardViewController(coordinator: self)
    }()

    var rootViewController: UIViewController {
        return splitViewController
    }

    var childCoordinators = [Coordinator]()

    init(_ navigationController: UINavigationController, api: DailyFxAPIProtocol) {
        self.navigationController = navigationController
        self.api = api
    }

    func start() {
        let articlesNavigationController = UINavigationController()
        let articlesCoordinator = ArticlesCoordinator(articlesNavigationController, api: api)
        articlesCoordinator.dashboardCoordinator = self
        articlesCoordinator.start()

        setupSplitView(articlesCoordinator)

        let articlesRootViewController = articlesCoordinator.rootViewController
        if #available(iOS 14.0, *) {
            splitViewController.setViewController(articlesRootViewController, for: .primary)
        } else {
            splitViewController.viewControllers = [articlesRootViewController]
        }

        childCoordinators.append(articlesCoordinator)
    }

    private func setupSplitView(_ masterCoordinator: Coordinator) {
        guard
            let navigationController = masterCoordinator.rootViewController as? UINavigationController,
            let masterViewController = navigationController.viewControllers.first as? ArticlesViewController
        else { return }

        splitViewController.delegate = masterViewController
    }

    private func coordinateToDetail() {
        let detailNavigationController = UINavigationController()
        let detailCoordinator = ArticleDetailCoordinator(detailNavigationController)
        detailCoordinator.start()

        let detailRootViewController = detailCoordinator.rootViewController
        detailRootViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        detailRootViewController.navigationItem.leftItemsSupplementBackButton = true

        splitViewController.showDetailViewController(detailRootViewController, sender: nil)
        childCoordinators.append(detailCoordinator)
    }
}

extension DashboardCoordinator: DashboardCoordinatorProtocol {
    func didSelectButton() {
        coordinateToDetail()
    }
}
