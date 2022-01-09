//
//  SceneDelegate.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 05/01/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let navigationController = UINavigationController()
        coordinator = AppCoordinator(navigationController)
        coordinator?.start()

        window?.rootViewController = coordinator?.rootViewController
        window?.makeKeyAndVisible()
    }
}
