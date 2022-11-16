//
//  SecondVC.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import UIKit

class SecondVC: UIViewController, StoryboardInstantiate {
    
    // Outlets
    @IBOutlet weak var topBannerVIew: CurveView!
    @IBOutlet weak var bottomBannerVIew: CurveView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblChosen: UILabel!

    var secondViewModel: SecondViewModel!

    
    override func viewDidLoad() { super.viewDidLoad()
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated)
        secondViewModel.showUsersList()
    }
    
    private func setupViews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            self?.topBannerVIew.drawSharpCurvedShape(.TopRightCornerSharpAngle)
            self?.bottomBannerVIew.drawSharpCurvedShape(.BottomRightCornerSharpAngle)
        }
        tableView.dataSource = nil
        tableView.delegate = nil
    }
    
    
    @IBAction func btnBackSelected(_ sender: UIButton?) {
        secondViewModel.btnBackSelected()
    }
    
    deinit {
        debugPrint("SecondVC")
    }
}
extension SecondVC: SecondScreenViewProtocol{
    func updateLoadingState(_ state: LoadingState) {
    }
    func usersLoadingSuccessful() {
        tableView.dataSource = self
        tableView.delegate = self
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.changeLblChosenText(self?.secondViewModel.chosenUserListItemViewModel.userFullName)
        }
    }
    func changeLblChosenText(_ text: String?) {
        UIView.transition(with: lblChosen,
                      duration: 0.25,
                       options: .transitionCrossDissolve,
                    animations: { [weak self] in
                        self?.lblChosen.text = text
                 }, completion: nil)
    }
}

extension SecondVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secondViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UserCell.cellFor(tableView, at: indexPath, for: secondViewModel.viewModelFor(indexPath))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if secondViewModel.shouldAnimatecell(indexPath){
            let animation = TableRowAnimations.Fade(height: cell.frame.height,
                                                    duration: 0.5,
                                                    delay: 0.05)
            let animator = Animator(animation: animation)
            animator.animate(cell: cell, at: indexPath, in: tableView)
            secondViewModel.updateUserItemViewModelForAnimateCellCompleted(indexPath)
        }
    }
}
