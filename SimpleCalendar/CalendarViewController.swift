//
//  ViewController.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

protocol SimpleCalendarCommunication {
    func willDismissCalendar(fromController: UIViewController, withSelection:[Day])
}

class CalendarViewController: UIViewController {
    
    fileprivate lazy var viewModel: CalendarViewModel = {
        let vm = CalendarViewModel(withController: self)
        return vm
    }()
    
    fileprivate let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    fileprivate let swipeDownGestrue: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .down
        return swipe
    }()
    
    fileprivate var calendarHeightConstraint: NSLayoutConstraint?
    
    fileprivate var calendarTopConstraint: NSLayoutConstraint?
    
    //MARK: Public Properties
    
    var calendar: CalendarView = CalendarView(frame: .zero)
    
    var delegate: SimpleCalendarCommunication?
    
    var frameHeight: CGFloat = 0 {
        didSet {
            if let calHeight = calendarHeightConstraint {
                calHeight.constant = self.frameHeight
                calHeight.isActive = true
            }
        }
    }
    
    var selected: [Day] {
        set {
            let sortedRange = newValue.sorted(by: {$0 <= $1})
            self.viewModel.startDay = sortedRange.first
            self.viewModel.endDay = sortedRange.last
        }
        get {
            return viewModel.range
        }
    }
    
    var currentMonth: Int? {
        get {
            return viewModel.currentMonth.first?.month
        }
    }

    //MARK: ViewController override
    override func viewDidLoad() {
        super.viewDidLoad()
        //view set up
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        tapGesture.addTarget(self, action: #selector(self.gestrueHandler(_:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        
        swipeDownGestrue.delegate = self
        swipeDownGestrue.addTarget(self, action: #selector(self.gestrueHandler(_:)))
        view.addGestureRecognizer(swipeDownGestrue)
        //subView set up
        
        self.calendar.grid.delegate = self
        _ = self.viewModel
        
        calendar.topBanner.nextMonthButton.addTarget(self, action: #selector(nextMonthButtonClicked(_:)), for: .touchUpInside)
        calendar.topBanner.prevMonthButton.addTarget(self, action: #selector(previousMonthButtonClicked(_:)), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        calendar.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        calendarTopConstraint = calendar.topAnchor.constraint(equalTo: view.bottomAnchor)
        calendarTopConstraint?.isActive = true
        calendarHeightConstraint = calendar.heightAnchor.constraint(equalToConstant: frameHeight)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadAllData()
        super.viewDidAppear(animated)
        if let topConstraint = self.calendarTopConstraint {
            topConstraint.constant = 0 - frameHeight - 5
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    //MARK: Action methods
    
    func gestrueHandler(_ sender: UIGestureRecognizer) {
        switch sender {
        case let tap as UITapGestureRecognizer:
            if tap == self.tapGesture {
                self.dismissWithAnimates()
            }
            break
        case let swip as UISwipeGestureRecognizer:
            if swip == self.swipeDownGestrue {
                self.dismissWithAnimates()
            }
            break
        default:
            break
        }
    }
    
    func nextMonthButtonClicked(_ sender: UIButton) {
        guard let firstDayOfCurrentMonth = viewModel.currentMonth.first else { return }
        if let firstDayOfNextMonth = firstDayOfCurrentMonth.day(byAdding: .month, value: 1) {
            viewModel.update(withDate: firstDayOfNextMonth)
            reloadAllData()
            updateSelection(self.calendar.grid.collectionView)
        }
    }
    
    func previousMonthButtonClicked(_ sender: UIButton) {
        guard let firstDayOfCurrentMonth = viewModel.currentMonth.first else { return }
        if let firstDayOfPrevMonth = firstDayOfCurrentMonth.day(byAdding: .month, value: -1) {
            viewModel.update(withDate: firstDayOfPrevMonth)
            reloadAllData()
            updateSelection(self.calendar.grid.collectionView)
        }
    }
    
    //MARK: Private Methods
    
    private func reloadAllData() {
        self.calendar.topBanner.topBannerLabel.text = self.viewModel.monthString
        self.calendar.grid.collectionView.reloadData()
        let width: CGFloat = CGFloat(self.calendar.bounds.size.width) / 7.0
        frameHeight = UIConfig.topBannerHeight + UIConfig.weekdayBannerHeight + CGFloat(self.viewModel.numberOfRows) * width
    }
    
    private func updateSelection(_ collectionView: UICollectionView) {
        guard let cMonth = currentMonth else { return }
        let constantOffset = viewModel.startWeekDay.number()
        let selectedInCurrentMonths = selected.filter { (day) -> Bool in
            return day.month == cMonth
        }.map { (day) -> IndexPath? in
            guard let index = self.viewModel.currentMonth.index(where: { $0 == day }) else { return nil }
            return IndexPath(item: (index + constantOffset - 1), section: 0)
        }
        selectedInCurrentMonths.forEach { (ip) in
            guard let ip = ip else { return }
            collectionView.selectItem(at: ip, animated: false, scrollPosition: .top)
        }
    }
}

//MARK: Collection view datasource extention
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

//MARK: CollectionView Delegate
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
                guard let cell = collectionView.cellForItem(at: ip) as? DayCell else { return }
                if cell.isSelected {
                    collectionView.deselectItem(at: ip, animated: false)
                    cell.selectedPosition = .undefined
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
            collectionView.deselectCells(forIndexPaths: collectionView.indexPathsForSelectedItems)
            for ip in selectedIndexPaths {
                collectionView.selectItem(at: ip, animated: false, scrollPosition: .left)
            }
        }
        
    }
    private func updateSelectedPosition(_ collectionView: UICollectionView) {
        //TODO: update the selected position of the cell to help for selection animation in the future
    }
}

//MARK: Collection View flow layout delegate
extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.calendar.bounds.size.width / 7.0
        return CGSize(width: width, height: width)
    }
}

//MARK: Collection View tap gestrue Recognizer delegate
extension CalendarViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        switch gestureRecognizer {
        case _ as UITapGestureRecognizer:
            guard let currentView = touch.view, currentView.isDescendant(of: self.calendar) else { return true }
            return false
        default:
            return true
        }
    }
}

//MARK: methods to present self to parentController
extension CalendarViewController {
    public func presentCalender(from parentController: UIViewController, completionHandler: ((Bool) -> Void)?) {
        parentController.addChildViewController(self)
        parentController.view.addSubview(self.view)
        if let completion = completionHandler {
            completion(true)
        }
        self.didMove(toParentViewController: parentController)
    }
    
    fileprivate func dismissWithAnimates() {
        if let topConstraint = calendarTopConstraint {
            topConstraint.constant = 0
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { [unowned self](finished) in
                if (finished) {
                    self.delegate?.willDismissCalendar(fromController: self, withSelection: self.selected)
                    self.willMove(toParentViewController: nil)
                    self.view.removeFromSuperview()
                    self.removeFromParentViewController()
                }
            })
        }
    }
}


