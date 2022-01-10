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
        guard let windowScene = (scene as? UIWindowScene), let api = buildAPI() else { return }
        window = UIWindow(windowScene: windowScene)

        let navigationController = UINavigationController()
        coordinator = AppCoordinator(navigationController, api: api)
        coordinator?.start()

        window?.rootViewController = coordinator?.rootViewController
        window?.makeKeyAndVisible()
    }

    private func buildAPI() -> DailyFxAPI? {
        guard let baseURL = URL(string: "https://content.dailyfx.com") else {
            assertionFailure("URL should never be nil")
            return nil
        }

        let config = Config(baseUrl: baseURL)
        let networking = Networking()
        return DailyFxAPI(config: config, networking: networking)
    }
}
