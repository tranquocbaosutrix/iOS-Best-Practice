//
//  HomeViewController.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 01/06/2022.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    /// UI Properties
    private lazy var tableViewCaseStudy: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
//        tableView.separatorStyle = .none
//        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CaseStudyUITableViewCell.self, forCellReuseIdentifier: CaseStudyUITableViewCell.className)
        
        return tableView
    }()

    /// Properties
    private let viewModel = HomeViewModel()

    /// MARK: Systems
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        checkNotificationPermission()
        showNotificationSettingsWarningAlert()
        observeAppState()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        print("HomeViewController was destroyed")
    }

    /// MARK: Functions
    private func setupUI() {
        title = "Home"
        view.addSubview(tableViewCaseStudy)

        tableViewCaseStudy.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top)
            make.bottom.equalTo(view.safeAreaInsets.bottom)
            make.right.left.equalToSuperview()
        }
    }

    private func showNotificationSettingsWarningAlert() {
        viewModel
            .showRequestNotiDeniedAlert = {
                self.showAlert(self,
                               title: "Warning",
                               message: "Notification permission is denied")
            }

        viewModel
            .dismissWarningAlert = {
                self.dismissAllPresentedAlertViewController()
            }
    }

    private func observeAppState() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(checkNotificationPermission),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }

    @objc private func checkNotificationPermission() {
        viewModel.checkNotificationAuthorizationStatus()
    }

}

/// MARK: Extensions
extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentCaseStudyList.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: CaseStudyUITableViewCell.self, for: indexPath)

        let caseStudy = viewModel.currentCaseStudyList[indexPath.row]

        cell.labelTitle.text = caseStudy.rawValue
        cell.labelSubtitle.text = caseStudy.rawValue

        return cell
    }

}

/// MARK: Extensions
extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let caseStudy = viewModel.currentCaseStudyList[indexPath.row]

        guard let destinationViewController = viewModel.destinationViewController(caseStudy) else { return }

        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
}
