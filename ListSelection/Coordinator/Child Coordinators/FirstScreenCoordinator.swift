//
//  FirstScreenCoordinator.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation
import UIKit

final class FirstScreenCoordinator : ChildCoordinator {

    weak var parentCoordinator: ParentCoordinator?
    var navigationController: UINavigationController
    

    init(_ navigationController : UINavigationController){
        self.navigationController = navigationController
    }
    
    func configureChildViewController() {
        let firstScreen = FirstVC.instantiateFrom(.main)
        firstScreen.firstViewModel = FirstViewModel(
            service: NetworkService(baseURLString: ServerUrl.url, parser: JSONParser()),
            view: firstScreen,
            validation: MinimumUsersSelection(),
            firstScreenChildCoordinator: self)
        
        self.navigationController.pushViewController(firstScreen, animated: false)
    }
    
    func configureSecondScreenVC( _ usersListItemViewModels: [UserListItemViewModel]) {
        let secondScreenChildCoordinator = ChildCoordinatorFactory.create(with: parentCoordinator!.navigationController, type: .secondScreen)
        secondScreenChildCoordinator.passParameter(value: SecondScreenParameter(selectedUsersVM: usersListItemViewModels))
        
        parentCoordinator?.childCoordinator.append(secondScreenChildCoordinator)
        parentCoordinator?.removeChildCoordinator(child: self)
        secondScreenChildCoordinator.parentCoordinator = self.parentCoordinator
        
        secondScreenChildCoordinator.configureChildViewController()

    
    }
    
    func configureAddUserFormVC(_ nextId: Int) {
        let addUserFormChildCoordinator = ChildCoordinatorFactory.create(with: parentCoordinator!.navigationController, type: .addUserFormScreen)
        addUserFormChildCoordinator.passParameter(value: AddUserFormScreenParameter(nextId: nextId))
        
        parentCoordinator?.childCoordinator.append(addUserFormChildCoordinator)
        parentCoordinator?.removeChildCoordinator(child: self)
        addUserFormChildCoordinator.parentCoordinator = self.parentCoordinator
        
        addUserFormChildCoordinator.configureChildViewController()
        
    }
    
    deinit {
        debugPrint("FirstScreenCoordinator")
    }
}
