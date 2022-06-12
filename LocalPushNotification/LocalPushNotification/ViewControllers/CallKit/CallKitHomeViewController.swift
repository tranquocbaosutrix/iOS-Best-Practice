//
//  CallKitHomeViewController.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 12/06/2022.
//

import UIKit

class CallKitHomeViewController: UIViewController {

    /// MARK: UI Properties
    private lazy var tableViewCalls: UITableView = {
        let tableView = UITableView()

        return tableView
    }()

    /// MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    deinit {
        print("CallKitHomeViewController was destroyed")
    }

    /// MARK: Functions
    private func setupUI() {
        view.addSubview(tableViewCalls)

        NSLayoutConstraint.activate([
            
        ])
    }

}
