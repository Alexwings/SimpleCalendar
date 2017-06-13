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
        
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        fmt.timeZone = TimeZone.current
        var firstDay = fmt.date(from: "1989-04-26")!
        for _ in 0..<6 {
            let day = Day(withDate: firstDay)
            viewModel.currentMonth.append(day)
            firstDay = Calendar.current.date(byAdding: .day, value: 1, to: firstDay)!
        }
        self.calendar.grid.collectionView.reloadData()
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
        return viewModel.currentMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dayCell = collectionView.dequeueReusableCell(withReuseIdentifier: DayGridView.cellIdentifier, for: indexPath)
        if let dayCell = dayCell as? DayCell {
            let day = viewModel.currentMonth[indexPath.item]
            dayCell.day = day
            return dayCell
        }
        return UICollectionViewCell()
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
            guard !unselectedIndices.isEmpty else {
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
            guard !indices.isEmpty else {
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
