//
//  UITableView+Extensions.swift
//  ListSelection
//
//  Created by Krunal on 31/07/22.
//

import UIKit

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }

        return lastIndexPath == indexPath
    }
}

