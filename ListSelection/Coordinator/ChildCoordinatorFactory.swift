//
//  ChildCoordinatorFactory.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation
import UIKit

enum ChildCoordinatorType {
    case firstScreen
    case secondScreen
    case addUserFormScreen
}

final class ChildCoordinatorFactory {
    static func create(with _navigationController: UINavigationController, type: ChildCoordinatorType) -> ChildCoordinator {

        switch type {
        case .firstScreen:
            return FirstScreenCoordinator(_navigationController)
        case .secondScreen:
            return SecondScreenCoordinator(_navigationController)
        case .addUserFormScreen:
            return AddUserFormCoordinator(_navigationController)
        }


    }
}
