//
//  ScreenPassingParameter.swift
//  ListSelection
//
//  Created by Krunal on 31/07/22.
//

import Foundation

struct SecondScreenParameter: Decodable {
    var selectedUsersVM: [UserListItemViewModel] = []
}

struct AddUserFormScreenParameter: Decodable {
    var nextId: Int = 0
}
