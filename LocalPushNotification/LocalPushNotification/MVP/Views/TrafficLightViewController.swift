//
//  TrafficLightViewController.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 15/06/2022.
//

import UIKit
import SnapKit

class TrafficLightViewController: UIViewController {

    /// MARK: Properties
    private let trafficLightPresenter = TrafficLightPresenter(trafficLightService: TrafficLightService())

    /// MARK: UI Properties
    lazy var labelDescription: UILabel = {
        let label = UILabel()

        return label
    }()

    lazy var buttonRedLight: UIButton = {
        let button = UIButton()
        button.setTitle("Turn to Red", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(didTapRedButton), for: .touchUpInside)
//        let padding16 = 16.0.asDesigned
//        button.contentEdgeInsets = UIEdgeInsets(top: padding16,
//                                                left: padding16,
//                                                bottom: padding16,
//                                                right: padding16)

        return button
    }()

    lazy var buttonGreenLight: UIButton = {
        let button = UIButton()
        button.setTitle("Turn to Green", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(didTapGreenButton), for: .touchUpInside)

        return button
    }()

    lazy var buttonYellowLight: UIButton = {
        let button = UIButton()
        button.setTitle("Turn to Yellow", for: .normal)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(didTapYellowButton), for: .touchUpInside)

        return button
    }()

    /// MARK: System
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupPresenter()
    }

    /// MARK: Functions
    private func setupPresenter() {
        trafficLightPresenter.setViewDelegate(trafficLightViewDelegate: self)
    }

    private func setupUI() {
        title = "MVP Best Practice"

        view.backgroundColor = .white

        view.addSubview(buttonRedLight)
        view.addSubview(buttonGreenLight)
        view.addSubview(buttonYellowLight)
        view.addSubview(labelDescription)

        let guide = view.safeAreaLayoutGuide
        let margin8 = 8.0.asDesigned
        let buttonWidth = 200.asDesigned
        let buttonHeight = 42.0.asDesigned

        buttonRedLight.snp.makeConstraints { make in
            make.top.equalTo(guide.snp.top)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
        }

        buttonGreenLight.snp.makeConstraints { make in
            make.top.equalTo(buttonRedLight.snp.bottom).offset(margin8)
            make.centerX.equalTo(buttonRedLight.snp.centerX)
            make.left.right.equalTo(buttonRedLight)
            make.height.equalTo(buttonRedLight.snp.height)
        }

        buttonYellowLight.snp.makeConstraints { make in
            make.top.equalTo(buttonGreenLight.snp.bottom).offset(margin8)
            make.centerX.equalTo(buttonRedLight.snp.centerX)
            make.left.right.equalTo(buttonRedLight)
            make.height.equalTo(buttonRedLight.snp.height)
        }

        labelDescription.snp.makeConstraints { make in
            make.top.equalTo(buttonYellowLight.snp.bottom).offset(margin8)
            make.centerX.equalTo(view.snp.centerX)
        }
    }

    @objc private func didTapRedButton() {
        setLightColor(colorName: .red)
    }

    @objc private func didTapGreenButton() {
        setLightColor(colorName: .green)
    }

    @objc private func didTapYellowButton() {
        setLightColor(colorName: .yellow)
    }

    private func setLightColor(colorName: TrafficLightColor) {
        trafficLightPresenter.trafficLightColorSelected(colorName: colorName)
    }
}

/// MARK: Extensions
extension TrafficLightViewController: TrafficLightViewDelegate {

    func displayTrafficLight(description: String) {
        labelDescription.text = description
    }

}
