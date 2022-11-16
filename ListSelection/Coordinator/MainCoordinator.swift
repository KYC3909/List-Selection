//
//  MainCoordinator.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation
import UIKit

final class MainCoordinator : ParentCoordinator {

    var navigationController: UINavigationController
    var childCoordinator: [ChildCoordinator] = [ChildCoordinator]()

    init(_ navigationController : UINavigationController){
        self.navigationController = navigationController
    }
    func configureNavigationController() {
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    func configureRootViewController() {
        self.configureNavigationController()
        
        let firstScreenChildCoordinator = ChildCoordinatorFactory.create(with: self.navigationController, type: .firstScreen)
        childCoordinator.append(firstScreenChildCoordinator)
        firstScreenChildCoordinator.parentCoordinator = self
        firstScreenChildCoordinator.configureChildViewController()
    }

    func removeChildCoordinator(child: ChildCoordinator) {
        for(index, coordinator) in childCoordinator.enumerated() {
            if(coordinator === child) {
                childCoordinator.remove(at: index)
                break
            }
        }
    }
    deinit {
        debugPrint("MainCoordinator")
    }
}
