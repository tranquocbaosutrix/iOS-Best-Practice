//
//  CaseStudyUITableViewCell.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 10/06/2022.
//

import Foundation
import UIKit

class CaseStudyUITableViewCell: UITableViewCell {
    
    /// MARK: UI Properties
    lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        
        return label
    }()
    
    lazy var labelSubtitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(12)
        label.textColor = .blue
        
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
    
    /// MARK: Functions
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelSubtitle)
        
        let padding8 = 8.asDesigned
        let padding16 = 16.asDesigned
        
        /// Layout UI (the first way) by using UI+Extensions
        //        labelTitle.anchor(top: contentView.topAnchor,
        //                          left: contentView.leftAnchor,
        //                          right: contentView.rightAnchor,
        //                          paddingTop: padding16,
        //                          paddingLeft: padding16,
        //                          paddingRight: padding16)
        //
        //        labelSubtitle.anchor(top: labelTitle.bottomAnchor,
        //                             left: labelTitle.leftAnchor,
        //                             bottom: contentView.bottomAnchor,
        //                             right: labelTitle.rightAnchor,
        //                             paddingTop: padding8,
        //                             paddingBottom: padding16)
        
        
        /// Layout UI (the second way) by using default autolayout
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelSubtitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: padding16),
            labelTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                             constant: padding16),
            labelTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                              constant: -padding16),
            
            labelSubtitle.topAnchor.constraint(equalTo: labelTitle.bottomAnchor,
                                               constant: padding8),
            labelSubtitle.leftAnchor.constraint(equalTo: labelTitle.leftAnchor),
            labelSubtitle.rightAnchor.constraint(equalTo: labelTitle.rightAnchor),
            labelSubtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -padding16),
        ])
        
        /// Layout UI (the third way) by using SnapKit
//        labelTitle.snp.makeConstraints { make in
//            make.left.top.right.equalToSuperview().inset(padding16)
//        }
//
//        labelSubtitle.snp.makeConstraints { make in
//            make.top.equalTo(labelTitle.snp.bottom).offset(padding8)
//            make.left.right.bottom.equalToSuperview().inset(padding16)
//        }
    }
    
}
