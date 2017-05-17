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
    
    weak var delegate: UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout? {
        didSet {
            self.collectionView.delegate = delegate
        }
    }
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cl = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cl.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        cl.register(DayCell.self, forCellWithReuseIdentifier: DayGridView.cellIdentifier)
        cl.translatesAutoresizingMaskIntoConstraints = false
        return cl
    }()
    
    override func setupViews() {
        super.setupViews()
        collectionView.backgroundColor = UIColor.white
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
