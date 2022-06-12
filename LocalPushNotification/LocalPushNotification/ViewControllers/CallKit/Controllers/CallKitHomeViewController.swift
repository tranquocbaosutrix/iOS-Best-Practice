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
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    /// MARK: Properties
    private let viewModel = CallKitViewModel()

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
        title = "CallKit"

        view.backgroundColor = .white
        view.addSubview(tableViewCalls)

        let guide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            tableViewCalls.topAnchor.constraint(equalTo: guide.topAnchor),
            tableViewCalls.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableViewCalls.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableViewCalls.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }

}
