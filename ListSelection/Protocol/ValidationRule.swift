//
//  ValidationRule.swift
//  ListSelection
//
//  Created by Krunal on 31/07/22.
//

import Foundation

protocol ValidationRule: AnyObject {
    associatedtype Object
    var message: String { get set }
    func performValidationOn(_ objects: Object) -> Bool
}

final class MinimumUsersSelection: ValidationRule {
    var message: String = ""
    typealias Object = [UserListItemViewModel]
    
    func performValidationOn(_ objects: [UserListItemViewModel]) -> Bool{
        let filteredCount = objects.filter { $0.selected }.count
        message = filteredCount > 2 ? "" : "Please select at least 3 Users!"
        return filteredCount > 2
    }
}

final class PhoneNumberValidator: ValidationRule {
    var message: String = ""
    typealias Object = String?
    
    func performValidationOn(_ objects: String?) -> Bool{
        guard let phone = objects, phone.count > 9 else {
            message = "Please enter phone number with 10 digits!"
            return false
        }
        return true
    }
}
