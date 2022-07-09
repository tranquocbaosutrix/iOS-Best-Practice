//
//  CoreMotionViewController.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 17/06/2022.
//

import Foundation
import UIKit

final class CoreMotionViewController: UIViewController {

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

        setUpUI()
//        observeAppState()
    }

    /// MARK: Functions
    private final func setUpUI() {
        view.backgroundColor = .white

        view.addSubview(labelCurrentUserActivity)

        NSLayoutConstraint.activate([
            labelCurrentUserActivity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelCurrentUserActivity.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private final func observeMotionActivity() {
        CoreMotionManager.shared.observeUserActivity { [weak self] userActivity in
            self?.viewModel.updateUserActivity(userActivity)
        }

        viewModel.userActivityHandler = { [weak self] activity in
            self?.labelCurrentUserActivity.text = activity
        }
    }

    private final func observeAppState() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(checkMotionPermission),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }

    @objc private final func checkMotionPermission() {
        viewModel.checkMotionAuthorizationStatus()
    }

}
