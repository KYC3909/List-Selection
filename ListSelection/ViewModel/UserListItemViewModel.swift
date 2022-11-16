//
//  UserListItemViewModel.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation


final class UserListItemViewModel: Decodable {
    let id : Int?
    let name : String?
    let email : String?
    let phone : String?
    var selected : Bool = false
    var addedByUser : Bool = false
    var animated : Bool = false

    init(_ user: User) {
        self.id = user.id
        self.name = user.name
        self.email = user.email
        self.phone = user.phone
    }
}

extension UserListItemViewModel {
    var userColorIndex : Int {
        return (id ?? 1) % colors.count
    }
    var userInitials : String {
        let initials = (self.name ?? "").components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
        return initials
    }
    var userFullName : String {
        return self.name ?? "N/A"
    }
    var userEmail : String {
        return self.email ?? "N/A"
    }
    var userPhone : String {
        return self.phone ?? "N/A"
    }
    var shouldAnimateCell : Bool {
        return !self.animated
    }
}
