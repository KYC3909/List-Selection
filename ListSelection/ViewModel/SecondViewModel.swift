//
//  SecondViewModel.swift
//  ListSelection
//
//  Created by Krunal on 31/07/22.
//

import Foundation


protocol UsersSelectedListViewModel: AnyObject {
    var chosenUserListItemViewModel: UserListItemViewModel! { get set }
    var usersSelectedListItemViewModels: [UserListItemViewModel] { set get }
    
    func showUsersList()
    func btnBackSelected()
    
    func numberOfRows() -> Int
    func viewModelFor(_ indexPath: IndexPath) -> UserListItemViewModel
}

final class SecondViewModel: UsersSelectedListViewModel {
    var chosenUserListItemViewModel: UserListItemViewModel!
    var usersSelectedListItemViewModels: [UserListItemViewModel] = []
        
    private weak var view: SecondScreenViewProtocol!
    private weak var secondScreenChildCoordinator : SecondScreenCoordinator?

    init(view: SecondScreenViewProtocol,
         secondScreenChildCoordinator : SecondScreenCoordinator,
         usersSelectedListVM: [UserListItemViewModel]) {
        self.view = view
        self.secondScreenChildCoordinator = secondScreenChildCoordinator
        self.usersSelectedListItemViewModels = usersSelectedListVM
     }
    
    func showUsersList() {
        self.view.updateLoadingState(.loading)

        let randomInt = Int.random(in: 0..<usersSelectedListItemViewModels.count)
        chosenUserListItemViewModel = usersSelectedListItemViewModels[randomInt]
        
        usersSelectedListItemViewModels.remove(at: randomInt)
        
        self.view.updateLoadingState(.complete)
        self.view.usersLoadingSuccessful()
    }
    func btnBackSelected() {
        self.secondScreenChildCoordinator?.popViewController()
    }
    deinit {
        debugPrint("SecondViewModel")
    }
}

extension SecondViewModel{
    func numberOfRows() -> Int {
        return usersSelectedListItemViewModels.count
    }
    
    func viewModelFor(_ indexPath: IndexPath) -> UserListItemViewModel {
        return usersSelectedListItemViewModels[indexPath.row]
    }
    
    func shouldAnimatecell(_ indexPath: IndexPath) -> Bool {
        return usersSelectedListItemViewModels[indexPath.row].shouldAnimateCell
    }
    
    func updateUserItemViewModelForAnimateCellCompleted(_ indexPath: IndexPath) {
        viewModelFor(indexPath).animated = true
    }
}
