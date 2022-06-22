//
//  CoreMotionViewController.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 17/06/2022.
//

import Foundation
import UIKit

class CoreMotionViewController: UIViewController {

    /// MARK: UI Properties
    private lazy var labelCurrentUserActivity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    /// MARK: Properties
    private let viewModel = CoreMotionViewModel()

    /// MARK: System
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
//        observeAppState()
    }

    /// MARK: Functions
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(labelCurrentUserActivity)

        NSLayoutConstraint.activate([
            labelCurrentUserActivity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelCurrentUserActivity.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func observeMotionActivity() {
        CoreMotionManager.shared.observeUserActivity { [weak self] userActivity in
            self?.viewModel.updateUserActivity(userActivity)
        }

        viewModel.userActivityHandler = { [weak self] activity in
            self?.labelCurrentUserActivity.text = activity
        }
    }

    private func observeAppState() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(checkMotionPermission),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(hideExistingAlert),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }

    @objc private func checkMotionPermission() {
        viewModel.checkMotionAuthorizationStatus()
    }

    @objc private func hideExistingAlert() {
        print("Hide existing alert")
        dismissAllPresentedAlertViewController()
    }

}
