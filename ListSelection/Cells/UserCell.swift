//
//  UserCell.swift
//  ListSelection
//
//  Created by Krunal on 31/07/22.
//

import UIKit

final class UserCell: UITableViewCell {
    static let id = "UserCell"
    
    // Outlets
    @IBOutlet weak var containerView: UIView?
    @IBOutlet weak var imgView: UIImageView?
    @IBOutlet weak var lblInitials: UILabel?
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var btnCheck: UIButton?

    override func awakeFromNib() { super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UserCell {
    
    static func cellFor(_ tableView: UITableView, at indexPath: IndexPath, for vm: UserListItemViewModel) -> UserCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.id, for: indexPath) as! UserCell
        cell.configure(vm)
        return cell
    }
    
    func configure(_ vm: UserListItemViewModel) {
        containerView?.backgroundColor = vm.selected ? .orange : .clear
        let image = vm.selected ? UIImage.init(systemName: "checkmark.circle") : nil
        btnCheck?.setImage(image, for: .normal)
        imgView?.backgroundColor = colors[vm.userColorIndex]
        lblInitials?.text = vm.userInitials
        lblName.text = vm.userFullName
        lblEmail.text = vm.userEmail
        lblPhone.text = vm.userPhone
    }
}
