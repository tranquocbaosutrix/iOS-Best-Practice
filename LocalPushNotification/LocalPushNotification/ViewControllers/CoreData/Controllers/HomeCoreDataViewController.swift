//
//  HomeCoreDataViewController.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 09/06/2022.
//

import UIKit

class HomeCoreDataViewController: UIViewController {

    /// MARK: UI Properties
    private lazy var tableViewTask: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewTaskUITableViewCell.self,
                           forCellReuseIdentifier: NewTaskUITableViewCell.className)

        return tableView
    }()

    /// MARK: Properties
    private let viewModel = HomeCoreDataViewModel()

    /// MARK: System
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        registerForKeyboardNotifications()
        observeViewModel()
    }

    deinit {
        removeObservers()
        print("HomeCoreDataViewController was destroyed")
    }

    /// MARK: Functions
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(tableViewTask)

        tableViewTask.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaInsets.top)
            make.bottom.equalTo(view.safeAreaInsets.bottom)
        }

        let addNewTaskBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                      target: self,
                                                      action: #selector(addNewTask))
        navigationItem.rightBarButtonItem = addNewTaskBarButtonItem
    }

    private func observeViewModel() {
        viewModel.reloadTaskList = { [weak self] in
            self?.tableViewTask.reloadData()
        }
    }

    override func animateConstraints(withKeyboardHeight keyboardHeight: CGFloat,
                                     showingKeyboard: Bool) {
        if viewModel.scrollToIndexIfNeeded() {
            tableViewTask.setContentInsetAndScrollIndicatorInsets(showingKeyboard ? keyboardHeight : 0)
            tableViewTask.scrollToRow(at: viewModel.indexPathForScrolling(showingKeyboard),
                                      at: .bottom,
                                      animated: true)
        }
    }

    @objc private func addNewTask() {
        showAddNewTaskAlert()
    }

    private func showAddNewTaskAlert() {
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new task",
                                      preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { [unowned self] _ in
            viewModel.saveNewTask(alert.textFields?.first?.text)
        }

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)

        alert.addTextField { textField in
            textField.placeholder = "Please add your task name"
        }

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert,
                animated: true,
                completion: nil)
    }
}

/// MARK: Extensions
extension HomeCoreDataViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentTaskList.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: NewTaskUITableViewCell.self,
                                                 for: indexPath)
        let index = indexPath.row
        cell.labelTitle.text = viewModel.taskName(at: index)
        cell.labelSubTitle.text = viewModel.taskCreatedDate(at: index)

        return cell
    }

}

/// MARK: Extensions
extension HomeCoreDataViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteExistingTask(at: indexPath)
        }
    }

}
