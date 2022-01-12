//
//  ArticleDetailCoordinator.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

protocol ArticleDetailCoordinatorProtocol: AnyObject { }

class ArticleDetailCoordinator: Coordinator, ArticleDetailCoordinatorProtocol {
    private let navigationController: UINavigationController
    private let report: Report

    var rootViewController: UIViewController {
        return navigationController
    }

    var childCoordinators = [Coordinator]()

    init(_ navigationController: UINavigationController, report: Report) {
        self.navigationController = navigationController
        self.report = report
    }

    func start() {
        navigateToArticleDetail()
    }
}

private extension ArticleDetailCoordinator {
    func navigateToArticleDetail() {
        let viewModel = ArticleDetailViewModel(coordinator: self, report: report)
        let viewController = ArticleDetailViewController(viewModel: viewModel)
        viewController.title = report.title
        navigationController.viewControllers = [viewController]
        navigationController.extendedLayoutIncludesOpaqueBars = true
    }
}
