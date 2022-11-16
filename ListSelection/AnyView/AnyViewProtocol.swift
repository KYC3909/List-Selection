//
//  Presenter.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation

protocol AnyViewProtocol: AnyObject {
    func updateLoadingState(_ state: LoadingState)
}

protocol FirstScreenViewProtocol: AnyViewProtocol {
    func updateLoadingState(_ state: LoadingState)
    func reloadSpecificUser(_ indexPath: IndexPath)
    func usersLoadingSuccessful()
    func usersLoadingFailed(with error: String)
    func enableDisableBtnNext(_ enable: Bool)
}

protocol SecondScreenViewProtocol: AnyViewProtocol {
    func updateLoadingState(_ state: LoadingState)
    func usersLoadingSuccessful()
}
