//
//  FirstVC.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import UIKit

class FirstVC: UIViewController, StoryboardInstantiate {

    // Outlets
    @IBOutlet weak var topBannerVIew: CurveView!
    @IBOutlet weak var bottomBannerVIew: CurveView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnNext: UIButton!


    var firstViewModel: FirstViewModel!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() { super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            self?.topBannerVIew.drawSharpCurvedShape(.TopRightCornerSharpAngle)
            self?.bottomBannerVIew.drawSharpCurvedShape(.BottomLeftCornerSharpAngle)
        }
        tableView.refreshControl = refreshControl
        pullToRefresh(nil)
    }
    
    @objc private func pullToRefresh(_ sender: AnyObject?) {
        firstViewModel.fetchUsers()
    }
    
    @IBAction func btnNextSelected(_ sender: UIButton?) {
        firstViewModel.btnNextSelected()
    }
    
    @IBAction func btnPlusSelected(_ sender: UIButton?) {
        firstViewModel.btnPlusSelected()
    }
    
    func displayAlertFor(_ error: String) {
//        let alert = UIAlertController.init(title: "Error!", message: error, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        alert.addAction(okAction)
//        self.present(alert, animated: true)
        
        let alert = ToastMessageView()
        alert.showAlertFor(error)
    }
    
    deinit {
        debugPrint("FirstVC")
    }
}


extension FirstVC: FirstScreenViewProtocol{
    func updateLoadingState(_ state: LoadingState){
        DispatchQueue.main.async { [weak self] in
            switch state {
            case .loading, .downloading:
                self?.refreshControl.beginRefreshing()
                LoadingView().showLoadingView()
            case .complete:
                self?.refreshControl.endRefreshing()
                LoadingView().hideLoadingView()
            }
        }
    }
    func reloadSpecificUser(_ indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            if let self = self, let cell = self.tableView.cellForRow(at: indexPath) as? UserCell {
                cell.configure(self.firstViewModel.viewModelFor(indexPath))
            }
        }
    }
    func usersLoadingSuccessful() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    func usersLoadingFailed(with error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.displayAlertFor(error)
        }
    }
    func enableDisableBtnNext(_ enable: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.btnNext.enableDisableView(enable)
        }
    }
}
extension FirstVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UserCell.cellFor(tableView, at: indexPath, for: firstViewModel.viewModelFor(indexPath))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        firstViewModel.updateUserItemViewModelFor(indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if firstViewModel.shouldAnimatecell(indexPath){        
            let animation = TableRowAnimations.Fade(height: cell.frame.height,
                                                    duration: 0.5,
                                                    delay: 0.05)
            let animator = Animator(animation: animation)
            animator.animate(cell: cell, at: indexPath, in: tableView)
            firstViewModel.updateUserItemViewModelForAnimateCellCompleted(indexPath)
        }
    }
}
