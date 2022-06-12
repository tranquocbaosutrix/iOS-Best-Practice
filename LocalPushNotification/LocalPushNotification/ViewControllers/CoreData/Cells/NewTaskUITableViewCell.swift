//
//  NewTaskUITableViewCell.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 11/06/2022.
//

import UIKit

class NewTaskUITableViewCell: UITableViewCell {

    ///MARK: UI Properties
    lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var labelSubTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    /// MARK: System
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("NewTaskUITableViewCell was destroyed")
    }

    /// MARK: Functions
    private func setupUI() {
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelSubTitle)

        let padding8 = 8.0.asDesigned
        let padding16 = 16.0.asDesigned
        
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: padding16),
            labelTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                             constant: padding16),
            labelTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                              constant: -padding16),

            labelSubTitle.leftAnchor.constraint(equalTo: labelTitle.leftAnchor),
            labelSubTitle.rightAnchor.constraint(equalTo: labelTitle.rightAnchor),
            labelSubTitle.topAnchor.constraint(equalTo: labelTitle.bottomAnchor,
                                               constant: padding8),
            labelSubTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -padding16)
        ])
    }
}
