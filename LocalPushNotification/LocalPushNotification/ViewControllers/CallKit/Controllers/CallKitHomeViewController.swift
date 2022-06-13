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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CallUITableViewCell.self,
                           forCellReuseIdentifier: CallUITableViewCell.className)

        return tableView
    }()

    private lazy var buttonMakeOutgoingCall: UIButton = {
        let button = UIButton()
        button.addTarget(self,
                         action: #selector(makeNewOutgoingCall),
                         for: .touchUpInside)
        button.setTitle("Make a new outgoing call", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    /// MARK: Properties
    private let viewModel = CallKitViewModel()

    /// MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        observeCalls()
    }

    deinit {
        print("CallKitHomeViewController was destroyed")
    }

    /// MARK: Functions
    private func setupUI() {
        title = "CallKit"

        view.backgroundColor = .white

        view.addSubview(buttonMakeOutgoingCall)
        view.addSubview(tableViewCalls)

        let guide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            buttonMakeOutgoingCall.topAnchor.constraint(equalTo: guide.topAnchor),
            buttonMakeOutgoingCall.leftAnchor.constraint(equalTo: view.leftAnchor),
            buttonMakeOutgoingCall.rightAnchor.constraint(equalTo: view.rightAnchor),
            buttonMakeOutgoingCall.heightAnchor.constraint(equalToConstant: 42.0.asDesigned),

            tableViewCalls.topAnchor.constraint(equalTo: buttonMakeOutgoingCall.bottomAnchor),
            tableViewCalls.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableViewCalls.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableViewCalls.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])

        let addNewCallBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                      target: self,
                                                      action: #selector(addNewCall))
        navigationItem.rightBarButtonItem = addNewCallBarButtonItem
    }

    @objc private func addNewCall() {
        showAddNewCallAlert()
    }

    private func showAddNewCallAlert() {
        let alert = UIAlertController(title: "New Call",
                                      message: "Add a new call",
                                      preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Call now",
                                       style: .default) { [weak self] _ in
            self?.viewModel.checkPhoneInput(alert.textFields?.first?.text)
        }

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)

        alert.addTextField { textField in
            textField.placeholder = "Please add your phone number"
        }

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert,
                animated: true,
                completion: nil)
    }

    private func displayIncomingCall(handle: String,
                                     hasVideo: Bool = false) {

        let backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            ProviderDelegate.shared.reportIncomingCall(uuid: UUID(),
                                                       handle: handle,
                                                       hasVideo: hasVideo) { _ in
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
            }
        }
    }

    private func observeCalls() {
        viewModel.reloadCallTableView = { [weak self] in
            self?.tableViewCalls.reloadData()
        }

        viewModel.makeNewCall = { [weak self] phoneNumber in
            self?.displayIncomingCall(handle: phoneNumber)
        }
    }

    @objc private func makeNewOutgoingCall() {
        viewModel.makeOutgoingCall()
    }

}

/// MARK: Extension
extension CallKitHomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.callCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: CallUITableViewCell.self, for: indexPath)

        let index = indexPath.row

        cell.labelCallName.text = viewModel.callName(at: index)
        cell.labelCallStatus.text = viewModel.callStatus(at: index)

        return cell
    }

}

/// MARK: Extension
extension CallKitHomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.endCall(at: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.holdCall(at: indexPath.row)
    }

}
