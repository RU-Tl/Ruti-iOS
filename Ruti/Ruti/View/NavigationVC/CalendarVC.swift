//
//  CalendarVC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/24/24.
//

import UIKit
import FSCalendar

class CalendarVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    let dayList = ["운동", "독서", "자기계발"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        cell.tagLabel.text = dayList[indexPath.row]
        cell.layer.cornerRadius = 13
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        
        
        if let cell = tagCollectionView.cellForItem(at: indexPath) as? TagCell {
            if indexPath.row == 0 {
                cell.layer.borderColor = UIColor.init(hexCode: CustomColor.Category.EXERCISE).cgColor
                cell.tagLabel.textColor = UIColor.init(hexCode: CustomColor.Category.EXERCISE)
                imgete.image = UIImage(named: "calender")
               
                let xmas = formatter.date(from: "2024-5-5")
                let xmas2 = formatter.date(from: "2024-5-12")
                let xmas3 = formatter.date(from: "2024-5-19")
                let xmas4 = formatter.date(from: "2024-5-3")
                let xmas5 = formatter.date(from: "2024-5-10")
                let xmas6 = formatter.date(from: "2024-5-17")
                let xmas7 = formatter.date(from: "2024-5-24")
                let xmas8 = formatter.date(from: "2024-5-23")
                
                let xmas9 = formatter.date(from: "2024-5-2")
                let xmas10 = formatter.date(from: "2024-5-9")
                let xmas11 = formatter.date(from: "2024-5-16")
                let xmas12 = formatter.date(from: "2024-5-23")

              
                healthArray = [xmas!, xmas2!, xmas3!, xmas4!, xmas5!, xmas6!, xmas7!, xmas8!, xmas9!, xmas10!, xmas11!, xmas12!]
                calendarView.appearance.eventDefaultColor = UIColor.init(hexCode: CustomColor.Category.EXERCISE)
                calendarView.reloadData()
            }else if indexPath.row == 1 {
                cell.layer.borderColor =  UIColor.init(hexCode: CustomColor.Category.READING).cgColor
                cell.tagLabel.textColor = UIColor.init(hexCode: CustomColor.Category.READING)
                //                imgete.image = UIImage(named: "calender2")
                imgete.image = UIImage(named: "calender")
                let xmas = formatter.date(from: "2024-5-1")
                let xmas2 = formatter.date(from: "2024-5-8")
                let xmas3 = formatter.date(from: "2024-5-15")
                let xmas4 = formatter.date(from: "2024-5-22")
                
                readingArray = [xmas!, xmas2!, xmas3!, xmas4!]
                calendarView.appearance.eventDefaultColor = .blue
                calendarView.reloadData()
            }else if indexPath.row == 2 {
                cell.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    
    @IBOutlet weak var imgete: UIImageView!
    @IBOutlet weak var tagBaseView: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    
    let currentDate = Date()
    
    var healthArray = [Date]()
    var readingArray = [Date]()
    var developArray = [Date]()
    
    var dates = [Date]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        //        readingArray = [sampleddate!]
        
        healthArray.append(currentDate)
        
        
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        tagCollectionView.allowsMultipleSelection = true
        
        let dfMatter = DateFormatter()
        dfMatter.locale = Locale(identifier: "ko_KR")
        dfMatter.dateFormat = "yyyy-MM-dd"
        
        // events
        let myFirstEvent = dfMatter.date(from: "2022-01-01")
        let mySecondEvent = dfMatter.date(from: "2022-01-31")
        
        //        healthArray = [myFirstEvent!, mySecondEvent!]
        
        
        initUI()
    }
    private lazy var tagCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        
        //tag 좌우
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func initUI() {
        title1.font = UIFont.h2()
        title2.font = UIFont.h2()
        title1.textColor = UIColor.init(hexCode: CustomColor.white)
        title2.textColor = UIColor.init(hexCode: CustomColor.white)
        
        tagBaseView.layer.cornerRadius = 10
        tagBaseView.addSubview(tagCollectionView)
        NSLayoutConstraint.activate([
            tagCollectionView.leadingAnchor.constraint(equalTo: tagBaseView.leadingAnchor),
            tagCollectionView.trailingAnchor.constraint(equalTo: tagBaseView.trailingAnchor),
            tagCollectionView.topAnchor.constraint(equalTo: tagBaseView.safeAreaLayoutGuide.topAnchor),
            tagCollectionView.bottomAnchor.constraint(equalTo: tagBaseView.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        self.calendarView.backgroundColor = .clear
        calendarView.appearance.headerTitleFont = UIFont.subTitle()
        calendarView.appearance.headerTitleColor = UIColor.init(hexCode: CustomColor.white)
        // Weekday 폰트 설정
        calendarView.appearance.weekdayFont = UIFont.caption1()
        calendarView.appearance.weekdayTextColor = UIColor.init(hexCode: CustomColor.white)
        
        // 각각의 일(날짜) 폰트 설정 (ex. 1 2 3 4 5 6 ...)
        calendarView.appearance.titleFont = UIFont.caption1()
        
        
        calendarView.calendarWeekdayView.weekdayLabels[0].text = "Su"
        self.calendarView.calendarWeekdayView.weekdayLabels[1].text = "Mo"
        self.calendarView.calendarWeekdayView.weekdayLabels[2].text = "Tu"
        self.calendarView.calendarWeekdayView.weekdayLabels[3].text = "We"
        self.calendarView.calendarWeekdayView.weekdayLabels[4].text = "Th"
        self.calendarView.calendarWeekdayView.weekdayLabels[5].text = "Fr"
        self.calendarView.calendarWeekdayView.weekdayLabels[6].text = "Sa"
        
        self.calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        self.calendarView.appearance.headerDateFormat = "M월"
        
        
        //오늘
        calendarView.appearance.todayColor = UIColor.init(hexCode: CustomColor.white_gray)
        calendarView.appearance.titleTodayColor = UIColor.init(hexCode: CustomColor.black)
        //selcted
        calendarView.appearance.selectionColor = UIColor.init(hexCode: CustomColor.Category.EXERCISE)
        
        //        calendarView.appearance.eventDefaultColor = .red
        
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        //        cell.eventIndicator.numberOfEvents = 1
        cell.eventIndicator.isHidden = false
        //        cell.eventIndicator.color = UIColor.green
    }
    
    @IBAction func moveToNext(_ sender: Any) {
        self.actionMoveDate(myCalendar: self.calendarView, moveUp: false)
    }
    @IBAction func moveToPrev(_ sender: Any) {
        self.actionMoveDate(myCalendar: self.calendarView, moveUp: true)
    }
    
    func actionMoveDate(myCalendar : FSCalendar,moveUp : Bool){
        let moveDr = moveUp ? 1 : -1
        if(myCalendar.scope.rawValue == 0){ //month
            if let newDate = Calendar.current.date(byAdding: .month, value: moveDr, to: myCalendar.currentPage) {
                myCalendar.setCurrentPage(newDate, animated: true)
            }
        }else{ // week
            if let newDate = Calendar.current.date(byAdding: .weekOfMonth, value: moveDr, to: myCalendar.currentPage) {
                myCalendar.setCurrentPage(newDate, animated: true)
            }
        }
    }
    
    // 이벤트 밑에 Dot 표시 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.healthArray.contains(date){
            return 1
        }
        if self.readingArray.contains(date){
            return 1
        }
        if self.developArray.contains(date){
            return 1
        }
        return 0
    }
    
    // Default Event Dot 색상 분기처리 - FSCalendarDelegateAppearance
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]?{
        if self.healthArray.contains(date){
            return [UIColor.green]
        }
        if self.readingArray.contains(date){
            return [UIColor.red]
        }
        if self.developArray.contains(date){
            return [UIColor.red]
        }
        return [UIColor.red]
    }
    
    // Selected Event Dot 색상 분기처리 - FSCalendarDelegateAppearance
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
        
        if self.healthArray.contains(date){
            return [UIColor.green]
        }
        if self.readingArray.contains(date){
            return [UIColor.red]
        }
        if self.developArray.contains(date){
            return [UIColor.red]
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor?
    {
        
        if  self.healthArray.contains(date) {
            return .red
        }
        else if self.readingArray.contains(date) {
            return .blue
        }
        else
        {
            return nil
        }
    }
    
}

extension CalendarVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label: UILabel = {
            let customLabel = UILabel()
            customLabel.font = UIFont.subTitle()
            if collectionView == tagCollectionView {
                customLabel.text = dayList[indexPath.row]
                customLabel.font = UIFont.body3()
                customLabel.textColor = UIColor.init(hexCode: CustomColor.clear_white)
            }
            customLabel.sizeToFit()
            return customLabel
        }()
        
        let size = label.frame.size
        //
        if collectionView == tagCollectionView {
            //            return CGSize(width:  15, height: 20)
            return CGSize(width: size.width + 19, height: 30)
        }
        return CGSize()
    }
}
