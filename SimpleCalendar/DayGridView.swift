//
//  DayGridView.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

class DayGridView: BaseView {
    
    static let cellIdentifier = "dayGridIdetifier"
    static let emptyCellIdentifier = "emptyDayIdentifier"
    
    var delegate: (UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout)? {
        set {
            self.collectionView.dataSource = newValue
            self.collectionView.delegate = newValue
        }
        get {
            return self.collectionView.delegate as? (UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout)
        }
    }
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cl = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cl.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        cl.bounces = false
        cl.allowsMultipleSelection = true
        cl.register(DayCell.self, forCellWithReuseIdentifier: DayGridView.cellIdentifier)
        cl.register(UICollectionViewCell.self, forCellWithReuseIdentifier: DayGridView.emptyCellIdentifier)
        cl.translatesAutoresizingMaskIntoConstraints = false
        return cl
    }()
    
    override func setupViews() {
        super.setupViews()
        collectionView.backgroundColor = UIConfig.backgroundColor
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

extension UICollectionView {
    func deselectCells(forIndexPaths indexPaths: [IndexPath]?) {
        guard let selectedIndexPaths = indexPaths else { return }
        for ip in selectedIndexPaths {
            guard let _ = self.cellForItem(at: ip) else { continue }
            self.deselectItem(at: ip, animated: false)
        }
    }
}
