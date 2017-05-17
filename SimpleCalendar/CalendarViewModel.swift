//
//  CalendarModel.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/16/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import Foundation
import UIKit

class CalendarViewModel: NSObject {
    
    var dayList: [Day] = []
    
    weak var controller: UIViewController?
    
    init(withController controller: UIViewController) {
        super.init()
        self.controller = controller
    }
}

extension CalendarViewModel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dayList.count
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dayCell = collectionView.dequeueReusableCell(withReuseIdentifier: DayGridView.cellIdentifier, for: indexPath)
        if let dayCell = dayCell as? DayCell {
//            let day = dayList[indexPath.item]
            
//            dayCell.label.text = String(day.day)
            dayCell.backgroundColor = .blue
            return dayCell
        }
        return UICollectionViewCell()
    }
}
