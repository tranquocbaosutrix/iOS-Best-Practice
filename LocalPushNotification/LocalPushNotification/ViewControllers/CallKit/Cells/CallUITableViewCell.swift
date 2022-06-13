//
//  CallKitTableViewCell.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 13/06/2022.
//

import UIKit

class CallUITableViewCell: UITableViewCell {

    /// MARK: UI Properties
    lazy var labelCallName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    /// MARK: Systems
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// MARK: Functions
    private func setupUI() {
        contentView.addSubview(labelCallName)

        let padding16 = 16.0.asDesigned

        NSLayoutConstraint.activate([
            labelCallName.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: padding16),
            labelCallName.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                                constant: padding16),
            labelCallName.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                 constant: padding16),
            labelCallName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -padding16)
        ])
    }
}
