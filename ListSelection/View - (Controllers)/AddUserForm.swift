//
//  AddUserForm.swift
//  ListSelection
//
//  Created by Krunal on 31/07/22.
//

import Foundation

class AddUserForm {
    private let addUserFormViewModel: AddUserFormViewModel

    init(_ addUserFormViewModel: AddUserFormViewModel) {
        self.addUserFormViewModel = addUserFormViewModel
    }
    
    func showFormFor(_ style: FormStyle) {
        addUserFormViewModel.showFormFor(style)
    }
    
    deinit{
        debugPrint("AddUserForm")
    }
}
