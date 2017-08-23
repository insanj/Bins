//
//  BinsViewController.swift
//  Bins
//
//  Created by Julian Weiss on 8/22/17.
//  Copyright © 2017 Julian Weiss. All rights reserved.
//

import UIKit

enum BinsState: Int {
    case none, setup, loading, loaded
}

class BinsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let binsCollectionView: UICollectionView
    let binsCollectionViewLayout: UICollectionViewFlowLayout

    var binsState: BinsState = .none
    var bins: [Bin]?

    init() {
        binsCollectionViewLayout = UICollectionViewFlowLayout()
        binsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: binsCollectionViewLayout)
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        binsCollectionViewLayout = UICollectionViewFlowLayout()
        binsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: binsCollectionViewLayout)
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPersistentBins()
    }

    // MARK: setup
    func setupPersistentBins() {
        binsState = .setup
        bins = BinsBackendManager.getAllBins()
        
        binsState = .loaded
        binsCollectionView.reloadData()
    }

    // MARK: - collection view
    // MARK: layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width / 2.0
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }

    // MARK: delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bins?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell.init()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
