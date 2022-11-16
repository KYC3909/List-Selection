//
//  FirstViewModel.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation


protocol UsersListViewModel: AnyObject {
    var usersListItemViewModels: [UserListItemViewModel] { set get }
    var addedUsersListItemViewModels: [UserListItemViewModel] { set get }
    func fetchUsers()
    func btnNextSelected()
    func btnPlusSelected()
    
    func addCreatedUserViaForm(_ user: User)
    
    func numberOfRows() -> Int
    func viewModelFor(_ indexPath: IndexPath) -> UserListItemViewModel
    func updateUserItemViewModelFor(_ indexPath: IndexPath)
}

final class FirstViewModel: UsersListViewModel {

    // (Dependency Injection)
    private let service: Service!
    private weak var view: FirstScreenViewProtocol!
    private let validation: MinimumUsersSelection!
    private let firstScreenChildCoordinator : FirstScreenCoordinator?
    
    var usersListItemViewModels = [UserListItemViewModel]()
    var addedUsersListItemViewModels = [UserListItemViewModel]()
    
    init(service: Service,
         view: FirstScreenViewProtocol,
         validation: MinimumUsersSelection,
         firstScreenChildCoordinator : FirstScreenCoordinator) {
        self.service = service
        self.view = view
        self.validation = validation
        self.firstScreenChildCoordinator = firstScreenChildCoordinator
    }
    
    func fetchUsers() {
        self.view.updateLoadingState(.loading)
        self.view.enableDisableBtnNext(false)
        
        guard let getUsersRequest = service.createRequestFor(for: .getUsers) else { return }
        service.performRequestFor(getUsersRequest, [User].self) { [weak self] (response) in
            guard let self = self else { return }
            self.view.updateLoadingState(.complete)
            switch response{
            case .success(let users):
                self.usersListItemViewModels.removeAll()
                self.usersListItemViewModels.append(contentsOf: self.addedUsersListItemViewModels)
                self.usersListItemViewModels.append(contentsOf: users.map { UserListItemViewModel($0) })
                self.view.usersLoadingSuccessful()
            case .failure(let error):
                debugPrint("Error in:\(#function): Error: \(error.localizedDescription)")
                self.view.usersLoadingFailed(with: error.localizedDescription)
            }
        }
    }
    
    func addCreatedUserViaForm(_ user: User) {
        let userListVM = UserListItemViewModel(user)
        userListVM.selected = true
        userListVM.addedByUser = true
        self.addedUsersListItemViewModels.insert(userListVM, at: 0)
        self.usersListItemViewModels.insert(userListVM, at: 0)
        self.view.usersLoadingSuccessful()
        self.enableDisableNextBtn()
    }
    
    func enableDisableNextBtn() {
        
        let isValid = self.validation.performValidationOn(usersListItemViewModels)
        self.view.enableDisableBtnNext(isValid)
    }
    
    func btnNextSelected() {
        let filtered = usersListItemViewModels.filter { $0.selected }
        let isValid = self.validation.performValidationOn(filtered)
        if isValid {
            self.firstScreenChildCoordinator?.configureSecondScreenVC(filtered)
        }else {
            self.view.usersLoadingFailed(with: self.validation.message)
        }
    }
    
    func btnPlusSelected() {
        self.firstScreenChildCoordinator?.configureAddUserFormVC(self.addedUsersListItemViewModels.count + 1000)
    }
    
    deinit {
        debugPrint("FirstViewModel")
    }
}

extension FirstViewModel{
    func numberOfRows() -> Int {
        return usersListItemViewModels.count
    }
    
    func viewModelFor(_ indexPath: IndexPath) -> UserListItemViewModel {
        return usersListItemViewModels[indexPath.row]
    }
    
    func updateUserItemViewModelFor(_ indexPath: IndexPath) {
        viewModelFor(indexPath).selected = !viewModelFor(indexPath).selected
        self.view.reloadSpecificUser(indexPath)
        
        self.enableDisableNextBtn()
    }
    
    func shouldAnimatecell(_ indexPath: IndexPath) -> Bool {
        return usersListItemViewModels[indexPath.row].shouldAnimateCell
    }
    
    func updateUserItemViewModelForAnimateCellCompleted(_ indexPath: IndexPath) {
        viewModelFor(indexPath).animated = true
    }
   
}
