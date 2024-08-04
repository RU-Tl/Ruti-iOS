//
//  RoutineVC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/24/24.
//

import UIKit

// 첫 화면
struct RoutineData {
    let category: Int
    let title: String
    let time: String
}

struct Routine {
    let routineCategories: String
    let routineContent: String
    let routineAlarmTime: String
    let routineStatus: String
    let routineId: Int
}

class RoutineVC: UIViewController {
    var routineData2 = [RoutineData]()
    var routineDataList = [Routine]()
    var dayStringList = [String]()
    var dayDateList = [Date]()
//    var dayRutine: Routine?
    
    @IBOutlet weak var emptytitle1: UILabel!
    @IBOutlet weak var emptytitle2: UILabel!
    @IBOutlet weak var emptytitle3: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title3: UILabel!
    
    @IBOutlet weak var weekView: UICollectionView!
    @IBOutlet weak var routineTable: UITableView!
    
    @IBOutlet weak var plusBtn: UIButton!
    
    var selectedDay = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // test용
        UserInfo.init()
        //        routineTable.isHidden = true
        
        // 기본 UI Setting
        initUI()
        
        // Rutine UI Setting
        makeWeekListData()
        
        // 오늘 날짜로 루틴 데이터 mapping 및 테이블 구성
        // 날짜 형식 : 2024-08-03
        getDayRoutine(day: dateToString(day: Date()))

      

        NotificationCenter.default.addObserver(self, selector: #selector(showPage(_:)), name: NSNotification.Name("noti"), object: nil)
    }

    /// 특정 날짜에 대한 루틴 데이터 maping
    /// - Parameter day: 선택된 날짜
    func getDayRoutine(day: String) {
        let request = APIRequest(method: .get,
                                 path: "/routine/\(UserInfo.memberId)/\(day)",
                                 param: nil,
                                 headers: APIConfig.authHeaders)
        
        APIService.shared.perform(request: request,
                                  completion: { [self] (result) in
            switch result {
            case .success(let data):
                if let data = data.body["data"] as? [[String:Any]] {
                    if data.count > 0 {
                        for list in data {
                            let dayRutine = Routine.init(routineCategories: list["routineCategories"] as! String,
                                                      routineContent: list["routineContent"] as! String,
                                                      routineAlarmTime: list["routineAlarmTime"] as! String,
                                                      routineStatus: list["routineStatus"] as! String,
                                                      routineId: list["routineId"] as! Int)
                            routineDataList.append(dayRutine)
                        }
                    }
                    else{
                        routineDataList.removeAll()
                    }
                    makeRoutineTableUI(routineList: routineDataList)
                }
            case .failure:
                print(APIError.networkFailed)
            }
        })
    }
    
    // 루틴 데이터 개수에 따라 UI 처리
    func makeRoutineTableUI(routineList: [Routine]){
        if routineList.count > 0 {       
            // routine 데이터 있는 경우
            print(routineDataList)
            
            let nib = UINib(nibName: "RoutineCell", bundle: nil)
            routineTable.register(nib, forCellReuseIdentifier: "RoutineCell")
            routineTable.reloadData()
            
            emptyView.isHidden = true
            if routineList.count == 3 {
                plusBtn.isHidden = true
            }
        }else{
            routineTable.reloadData()
            emptyView.isHidden = false
            plusBtn.isHidden = false
        }
    }
    
    // 주간 캘린더 데이터 생성
    func makeWeekListData(){
        var tmpDayStringList = [String]()
        var tmpDayDateList = [Date]()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd E"
        formatter.locale = Locale(identifier:"ko_KR")
        
        let today = Date()
        tmpDayDateList.append(today)
        let date_string1 = formatter.string(from: today)
        tmpDayStringList.append(date_string1)
        
        for i in 1...6 {
            let beforeDay = Calendar.current.date(byAdding: .day, value: -i, to: today)
            let date_string2 = formatter.string(from: beforeDay!)
            tmpDayDateList.append(beforeDay!)
            tmpDayStringList.append(date_string2)
        }
        dayDateList = tmpDayDateList.reversed()
        dayStringList = tmpDayStringList.reversed()
    }
    
    // Date tyep To String Type
    func dateToString(day: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        let str = formatter.string(from: day)
        return str
    }
    
    @objc func showPage(_ notification:Notification) {
        //push
//        if let boardVC = self.storyboard?.instantiateViewController(withIdentifier: "RutineStartVC") as? RutineStartVC{
//            self.navigationController?.pushViewController(boardVC, animated: true)
//        }
        
        //present
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "RutineStartVC")
        let navController = UINavigationController(rootViewController: popupVC)
        navController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(navController, animated:true, completion: nil)
    }
    
    var state = 1
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        //
//        if state == 2{
//            routineData.append(RoutineData(category: 2, title: "취침 전 책 읽기", time: "PM 12:30"))
//            routineTable.reloadData()
//        }
          
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white  // 색상 변경
        self.navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBAction func plusBtn(_ sender: Any) {
//        routineDataList.append(RoutineData(category: 2, title: "취침 전 책 읽기", time: "PM 10:30"))
    }
    

    
    // init UI data setting
    func initUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        plusBtn.backgroundColor = .clear
        plusBtn.layer.borderWidth = 1
        plusBtn.layer.borderColor = UIColor.init(hexCode: CustomColor.Category.EXERCISE).cgColor
        plusBtn.layer.cornerRadius = 10
        plusBtn.setTitleColor(UIColor.init(hexCode: CustomColor.Category.EXERCISE), for: .normal)
        
        title1.font = UIFont.h2()
        title2.font = UIFont.h2()
        title3.font = UIFont.h2()
        
        title1.text = "\(UserInfo.name)님, 반가워요"
        title1.textColor = UIColor.init(hexCode: CustomColor.white)
        title2.textColor = UIColor.init(hexCode: CustomColor.Category.EXERCISE)
        title3.textColor = UIColor.init(hexCode: CustomColor.white)
        
        emptytitle1.font = UIFont.h4()
        emptytitle1.textColor = UIColor.init(hexCode: CustomColor.light_gray)
        emptytitle2.font = UIFont.body1()
        emptytitle2.textColor = UIColor.init(hexCode: CustomColor.light_gray)
        emptytitle3.font = UIFont.body1()
        emptytitle3.textColor = UIColor.init(hexCode: CustomColor.light_gray)
    }
}

extension RoutineVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCell.identifier, for: indexPath) as? DailyCell else {
            return UICollectionViewCell()
        }
        
        cell.dayLabel.text = dayStringList[indexPath.row]
        cell.dayLabel.font = UIFont.body4()

        if indexPath.row == 6 {
            collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
            cell.isSelected = true
        }else{
            cell.isSelected = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDay = dayDateList[indexPath.row]
        // routineDataList clear 후 조회
        routineDataList.removeAll()
        getDayRoutine(day: dateToString(day: selectedDay))
    }
}

extension RoutineVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        routineDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineCell", for: indexPath) as! RoutineCell
        cell.selectionStyle = .none
        
        // 루틴 정보
        cell.routineTitle.text = routineDataList[indexPath.row].routineContent
        cell.routineTime.text = routineDataList[indexPath.row].routineAlarmTime
        cell.tagTitle.text = routineDataList[indexPath.row].routineCategories == "EXERCISE" ? "운동" : "독서"
        
        //
        if routineDataList[indexPath.row].routineCategories == "EXERCISE"
        {
            cell.tagView.layer.borderColor = UIColor.init(hexCode: CustomColor.Category.EXERCISE).cgColor
            cell.tagTitle.textColor = UIColor.init(hexCode: CustomColor.Category.EXERCISE)
            
        }else{
            cell.tagView.layer.borderColor = UIColor.init(hexCode: CustomColor.Category.READING).cgColor
            cell.tagTitle.textColor = UIColor.init(hexCode: CustomColor.Category.READING)
            cell.routineCheckImg.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 137
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let boardVC = self.storyboard?.instantiateViewController(withIdentifier: "RoutineDetailVC") as? RoutineDetailVC{
            self.navigationController?.pushViewController(boardVC, animated: true)
            boardVC.categoryType = 1
        }
    }
}
