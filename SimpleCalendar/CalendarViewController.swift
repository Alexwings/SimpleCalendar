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
    
    var frameHeight: CGFloat = 0 {
        didSet {
            self.calendar.setNeedsLayout()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendar.grid.delegate = self
        _ = self.viewModel
        let width: Double = Double(self.calendar.bounds.size.width) / 7.0
        frameHeight = UIConfig.topBannerHeight + UIConfig.weekdayBannerHeight + CGFloat(self.viewModel.numberOfRows * width)
        self.calendar.grid.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        calendar.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        calendar.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: frameHeight).isActive = true
        super.viewDidAppear(animated)
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.startWeekDay {
        case .undefined:
            return viewModel.currentMonth.count
        default:
            return viewModel.currentMonth.count + viewModel.startWeekDay.number() - 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let startIndex = viewModel.startWeekDay.number() - 1
        let actuallIndex = indexPath.item - startIndex
        var dayCell = collectionView.dequeueReusableCell(withReuseIdentifier: DayGridView.emptyCellIdentifier, for: indexPath)
        if indexPath.item >= startIndex {
            dayCell = collectionView.dequeueReusableCell(withReuseIdentifier: DayGridView.cellIdentifier, for: indexPath)
            if let dayCell = dayCell as? DayCell {
                let day = viewModel.currentMonth[actuallIndex]
                dayCell.day = day
                return dayCell
            }
        }
        return dayCell
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DayCell, cell.isSelected else {
            return
        }
        handleSelect(collectionView, forCell: cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DayCell, !cell.isSelected else {
            return
        }
        handleDeselected(collectionView, forCell: cell)
    }
    
    private func handleDeselected(_ collectionView: UICollectionView, forCell cell: DayCell) {
        self.viewModel.deselect(day: cell.day) { [unowned self](unselectedIndices) in
            guard let unselectedIndices = unselectedIndices else {
                let alert = UIAlertController(title: "No Day Selected", message: "No day assigned for this cell, please select another day", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            let filteredIndices = unselectedIndices.filter({ (i) -> Bool in
                return i != -1
            })
            let unselectedIndexPaths = filteredIndices.map({ (index) -> IndexPath in
                return IndexPath(item: index, section: 0)
            })
            for ip in unselectedIndexPaths {
                guard let cell = collectionView.cellForItem(at: ip) else { return }
                if cell.isSelected {
                    collectionView.deselectItem(at: ip, animated: false)
                }
            }
        }
    }
    
    private func handleSelect(_ collectionView: UICollectionView, forCell cell: DayCell) {
        /*
            1.Get current day
            2.update selectedRange in ViewModel
        */
        self.viewModel.select(day: cell.day) { [unowned self](indices) in
            guard let indices = indices else {
                let alert = UIAlertController(title: "No Day Selected", message: "No day assigned for this cell, please select another day", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            let filteredIndices = indices.filter({ (i) -> Bool in
                return i != -1
            })
            let selectedIndexPaths = filteredIndices.map({ (index) -> IndexPath in
                return IndexPath(item: index, section: 0)
            })
            for ip in selectedIndexPaths {
                guard let cell = collectionView.cellForItem(at: ip) else { continue }
                if !cell.isSelected {
                    collectionView.selectItem(at: ip, animated: false, scrollPosition: .left)
                }
            }
        }
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.calendar.bounds.size.width / 7.0
        return CGSize(width: width, height: width)
    }
}
