//
//  SceneDelegate.swift
//  Homework 17
//
//  Created by Kristina Korotkova on 13/02/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = PasswordController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
