//
//  PopupVC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/24/24.
//

import UIKit
import FSCalendar

class PopupVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func initUI() {
        baseView.layer.cornerRadius = 10
//        self.calendarView.locale = Locale(identifier: "ko_KR")
        self.calendarView.delegate = self
        self.calendarView.dataSource = self

        self.calendarView.calendarWeekdayView.weekdayLabels[0].text = "Su"
        self.calendarView.calendarWeekdayView.weekdayLabels[1].text = "Mo"
        self.calendarView.calendarWeekdayView.weekdayLabels[2].text = "Tu"
        self.calendarView.calendarWeekdayView.weekdayLabels[3].text = "We"
        self.calendarView.calendarWeekdayView.weekdayLabels[4].text = "Th"
        self.calendarView.calendarWeekdayView.weekdayLabels[5].text = "Fr"
        self.calendarView.calendarWeekdayView.weekdayLabels[6].text = "Sa"
        
        self.calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        self.calendarView.appearance.headerDateFormat = "M월"
    }
    
    @IBAction func moveToNext(_ sender: Any) {
        self.scrollCurrentPage(isPrev: true)
    }
    @IBAction func moveToPrev(_ sender: Any) {
        self.scrollCurrentPage(isPrev: false)
    }
    
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
//        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
//        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
}
