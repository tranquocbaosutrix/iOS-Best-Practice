//
//  CallKitTableViewCell.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 13/06/2022.
//

import UIKit

final class CallUITableViewCell: UITableViewCell {

    /// MARK: UI Properties
    lazy var labelCallName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var labelCallStatus: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    /// MARK: Systems
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// MARK: Functions
    private final func setUpUI() {
        contentView.addSubview(labelCallName)
        contentView.addSubview(labelCallStatus)

        let padding16 = 16.0.asDesigned

        NSLayoutConstraint.activate([
            labelCallStatus.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                 constant: padding16),
            labelCallStatus.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                   constant: -padding16),

            labelCallName.topAnchor.constraint(equalTo: labelCallStatus.topAnchor),
            labelCallName.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                                constant: padding16),
            labelCallName.rightAnchor.constraint(equalTo: labelCallStatus.leftAnchor,
                                                 constant: -padding16),
            labelCallName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -padding16)
        ])
    }
}
