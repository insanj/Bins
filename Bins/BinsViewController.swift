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
        
        // setup navigation controller (if exists)
        if let nc = navigationController {
            title = "Bins"
            nc.navigationBar.barStyle = .black
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        }
        
        // setup collection view
        binsCollectionView.register(BinsCollectionViewCell.self, forCellWithReuseIdentifier: BinsCollectionViewCell.reuseIdentifier)
        binsCollectionView.delegate = self
        binsCollectionView.dataSource = self
        
        binsCollectionView.alwaysBounceVertical = true
        binsCollectionView.indicatorStyle = .white
        binsCollectionView.backgroundColor = UIColor.black
        binsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(binsCollectionView)
        
        binsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        binsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        binsCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        binsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        // setup data
        binsState = .setup
        setupPersistentBins()
    }

    // MARK: setup
    func setupPersistentBins() {
        binsState = .loading
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BinsCollectionViewCell.reuseIdentifier, for: indexPath) as? BinsCollectionViewCell {
            cell.bin = bins?[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell.init() // just for safety
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    // MARK: - actions
    func addButtonTapped() {
        let addAlert = UIAlertController(title: "Add Bin", message: "", preferredStyle: .alert)
        addAlert.addTextField { (textField) in
            textField.placeholder = "this will look better soon"
        }
        addAlert.addAction(UIAlertAction.init(title: "Done", style: .default, handler: { (action) in
            if let textField = addAlert.textFields?.first, let text = textField.text {
                self.addBin(text)
            }
        }))
        addAlert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(addAlert, animated: true, completion: nil)
    }
    
    func addBin(_ text: String) {
        BinsBackendManager.createBin(name: text)
        setupPersistentBins()
    }
}
