//
//  ArticleDetailCoordinator.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

protocol ArticleDetailCoordinatorProtocol: AnyObject { }

class ArticleDetailCoordinator: Coordinator, ArticleDetailCoordinatorProtocol {
    private var navigationController: UINavigationController

    var rootViewController: UIViewController {
        return navigationController
    }

    var childCoordinators = [Coordinator]()

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigateToArticleDetail()
    }
}

private extension ArticleDetailCoordinator {
    func navigateToArticleDetail() {
        let viewModel = ArticleDetailViewModel(coordinator: self)
        let viewController = ArticleDetailViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}
