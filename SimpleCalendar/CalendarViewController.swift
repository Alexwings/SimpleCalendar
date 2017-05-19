//
//  ViewController.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    lazy var viewModel: CalendarViewModel = {
        let vm = CalendarViewModel(withController: self)
        return vm
    }()
    
    var calendar: CalendarView = CalendarView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendar.grid.delegate = self
        _ = self.viewModel
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        calendar.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        calendar.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: UIConfig.mainFrameHeight).isActive = true
        super.viewDidAppear(animated)
    }
    
}

extension CalendarViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return dayList.count
        return UIConfig.test.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dayCell = collectionView.dequeueReusableCell(withReuseIdentifier: DayGridView.cellIdentifier, for: indexPath)
        if let dayCell = dayCell as? DayCell {
            //            let day = dayList[indexPath.item]
            //            dayCell.label.text = String(day.day)
            let testText = String(UIConfig.test[indexPath.item])
            dayCell.label.text = testText
            return dayCell
        }
        return UICollectionViewCell()
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.calendar.bounds.size.width / 7.0
        return CGSize(width: width, height: width)
    }
}
