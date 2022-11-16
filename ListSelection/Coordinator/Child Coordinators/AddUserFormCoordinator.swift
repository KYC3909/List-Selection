//
//  AddUserFormCoordinator.swift
//  ListSelection
//
//  Created by Krunal on 31/07/22.
//

import Foundation
import UIKit

final class AddUserFormCoordinator : ChildCoordinator {

    weak var parentCoordinator: ParentCoordinator?
    var navigationController: UINavigationController
    private var nextId: Int = 0
    
    private var addUserForm: AddUserForm?
    
    init(_ navigationController : UINavigationController){
        self.navigationController = navigationController
    }
    
    func configureChildViewController() {
        addUserForm = AddUserForm(AddUserFormViewModel(nextId, self))
        addUserForm?.showFormFor(.metallic)
    }
    
    func dismissViewController(_ user: User) {
        parentCoordinator?.removeChildCoordinator(child: self)
        let filtered = navigationController.viewControllers.filter { $0 is FirstVC }
        if filtered.count > 0 {
            if let vc = filtered[0] as? FirstVC {
                vc.firstViewModel.addCreatedUserViaForm(user)
            }
        }
    }
    deinit {
        debugPrint("AddUserFormCoordinator")
    }
}
