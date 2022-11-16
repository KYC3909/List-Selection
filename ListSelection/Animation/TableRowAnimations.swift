//
//  TableRowAnimations.swift
//  ListSelection
//
//  Created by Krunal on 31/07/22.
//

import UIKit

typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

enum TableRowAnimations {

    // Animate Rows using Time Interval and Delay within each cell
    static func Fade(height: CGFloat, duration: TimeInterval, delay: Double) -> Animation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: 0, y: height / 2)
            cell.alpha = 0

            UIView.animate(
                withDuration: duration,
                delay: delay * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                    cell.alpha = 1
            })
        }
    }
}


//
final class Animator {
    private var hasAnimatedAllCells = false
    private let animation: Animation

    init(animation: @escaping Animation) {
        self.animation = animation
    }

    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedAllCells else {
            return
        }

        animation(cell, indexPath, tableView)

        hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }
}
