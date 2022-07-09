//
//  MainCollectionViewController.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 09/07/2022.
//

import UIKit
import SnapKit

final class MainCollectionViewController: UIViewController {

    /// MARK: Properties
    private let viewModel = MainCollectionViewModel()

    // MARK: UI Properties
    private lazy var collectionViewColors: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        layout.sectionInset = UIEdgeInsets(top: 20,
                                           left: 10,
                                           bottom: 10,
                                           right: 10).asDesigned

        layout.itemSize = CGSize(width: 60,
                                 height: 60).asDesigned

        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        return collectionView
    }()

    /// MARK: System
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }

    override func loadView() {
        view = collectionViewColors
    }

    /// MARK: Functions
    private final func setUpUI() {
        view.backgroundColor = .white
    }

}

/// MARK: Extensions
extension MainCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item

        print("Did select item at index: \(index), with color: \(viewModel.colorItem(at: index).toRGBAString())")
    }

}

/// MARK: Extensions
extension MainCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.listOfColors().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        cell.backgroundColor = viewModel.colorItem(at: indexPath.item)

        return cell
    }


}
