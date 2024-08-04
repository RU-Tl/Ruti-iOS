//
//  PopupVC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/24/24.
//

import UIKit
import FSCalendar

protocol PopupVCDelegate: AnyObject {
    func didDismissPopupVC(selectedDate: Date)
}

// 팝업 캘린더 뷰
class PopupVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupGesture() 
        initUI()
    }

    var popupVCDelegate: PopupVCDelegate?

    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        self.popupVCDelegate?.didDismissPopupVC(selectedDate: calendarView.selectedDate ?? Date())
        self.dismiss(animated: true)
    }
    
    @objc private func viewTapped() {
        self.dismiss(animated: true)
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        baseView.addGestureRecognizer(tapGesture)
        baseView.isUserInteractionEnabled = true
    }
    
    func initUI() {
        baseView.layer.cornerRadius = 10
        baseView.layer.borderWidth = 1
        baseView.layer.borderColor = UIColor.init(hexCode: CustomColor.white_gray).cgColor
        
//        self.calendarView.locale = Locale(identifier: "ko_KR")
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
              
        self.calendarView.backgroundColor = .clear
        calendarView.appearance.headerTitleFont = UIFont.subTitle()
        calendarView.appearance.headerTitleColor = UIColor.init(hexCode: CustomColor.white)
        // Weekday 폰트 설정
        calendarView.appearance.weekdayFont = UIFont.body4()
        calendarView.appearance.weekdayTextColor = UIColor.init(hexCode: CustomColor.white)
        
        // 각각의 일(날짜) 폰트 설정 (ex. 1 2 3 4 5 6 ...)
        calendarView.appearance.titleFont = UIFont.caption1()
  
        
        self.calendarView.calendarWeekdayView.weekdayLabels[0].text = "Su"
        self.calendarView.calendarWeekdayView.weekdayLabels[1].text = "Mo"
        self.calendarView.calendarWeekdayView.weekdayLabels[2].text = "Tu"
        self.calendarView.calendarWeekdayView.weekdayLabels[3].text = "We"
        self.calendarView.calendarWeekdayView.weekdayLabels[4].text = "Th"
        self.calendarView.calendarWeekdayView.weekdayLabels[5].text = "Fr"
        self.calendarView.calendarWeekdayView.weekdayLabels[6].text = "Sa"
        
        self.calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        self.calendarView.appearance.headerDateFormat = "M월"
        
        calendarView.appearance.todayColor = UIColor.init(hexCode: CustomColor.white_gray)
        calendarView.appearance.titleTodayColor = UIColor.init(hexCode: CustomColor.black)
        //selcted
        calendarView.appearance.selectionColor = UIColor.init(hexCode: CustomColor.Category.EXERCISE)
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
