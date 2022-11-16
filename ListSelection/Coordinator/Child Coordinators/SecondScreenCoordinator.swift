//
//  SecondScreenCoordinator.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation
import UIKit

final class SecondScreenCoordinator : ChildCoordinator {
    weak var parentCoordinator: ParentCoordinator?
    var navigationController: UINavigationController
    private var selectedUsersListViewModel: [UserListItemViewModel] = []


    init(_ navigationController : UINavigationController){
        self.navigationController = navigationController
    }
    
    func configureChildViewController() {
        let secondVC = SecondVC.instantiateFrom(.main)
        secondVC.secondViewModel = SecondViewModel(view: secondVC,
                                                   secondScreenChildCoordinator: self,
                                                   usersSelectedListVM: selectedUsersListViewModel)
        self.navigationController.pushViewController(secondVC, animated: true)
    }
    
    func passParameter(value: Decodable) {
        guard let parameter = value as? SecondScreenParameter else {return}
        self.selectedUsersListViewModel = parameter.selectedUsersVM
    }

    
    func popViewController() {
        parentCoordinator?.removeChildCoordinator(child: self)
        self.navigationController.popViewController(animated: true)
    }
    
    deinit {
        debugPrint("SecondScreenCoordinator")
    }
}
