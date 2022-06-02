//
//  AppCoordinator.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 01/06/22.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {

        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}
