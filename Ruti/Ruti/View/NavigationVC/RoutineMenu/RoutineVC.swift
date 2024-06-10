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

class RoutineVC: UIViewController {
    var routineData = [RoutineData]()
    var dayStringList = [String]()
    var dayDateList = [Date]()
    
    @IBOutlet weak var emptytitle3: UILabel!
    @IBOutlet weak var emptytitle2: UILabel!
    @IBOutlet weak var emptytitle1: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title3: UILabel!
    
    @IBOutlet weak var weekView: UICollectionView!
    @IBOutlet weak var routineTable: UITableView!
    
    @IBOutlet weak var plusBtn: UIButton!
    
    var selectedDay = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayStringList = weekList()

        initUI()
        routineTable.isHidden = true
        
        
        
        let nib = UINib(nibName: "RoutineCell", bundle: nil)
        routineTable.register(nib, forCellReuseIdentifier: "RoutineCell")
        navigationController?.setNavigationBarHidden(true, animated: true)
        routineData.append(RoutineData(category: 1, title: "출근 전 아침 러닝", time: "AM 7:20"))
        //        routineData.append(RoutineData(category: 2, title: "취침 전 책 읽기", time: "PM 12:30"))
        NotificationCenter.default.addObserver(self, selector: #selector(showPage(_:)), name: NSNotification.Name("noti"), object: nil)
    }
    
    func weekList() -> [String] {
        var tmpDayStringList = [String]()
        var tmpDayDateList = [Date]()
        var formatter = DateFormatter()
        formatter.dateFormat = "dd E"
        formatter.locale = Locale(identifier:"ko_KR")
        
        let today = Date()
        tmpDayDateList.append(today)
        var date_string1 = formatter.string(from: today)
        tmpDayStringList.append(date_string1)
        
        for i in 1...6 {
            let beforeDay = Calendar.current.date(byAdding: .day, value: -i, to: today)
            var date_string2 = formatter.string(from: beforeDay!)
            
            tmpDayDateList.append(beforeDay!)
            tmpDayStringList.append(date_string2)
        }
        
        dayDateList = tmpDayDateList.sorted(by: <)
        return tmpDayStringList.sorted(by: <)
    }
    
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
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white  // 색상 변경
        self.navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //
    @IBAction func plusBtn(_ sender: Any) {
        routineData.append(RoutineData(category: 2, title: "취침 전 책 읽기", time: "PM 10:30"))
     
    }
    
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
                    for list in data {
                        print(list["routineCategories"])
                    }
                }
            case .failure:
                print(APIError.networkFailed)
            }
        })
    }
    
    func initUI() {
        plusBtn.backgroundColor = .clear
        plusBtn.layer.borderWidth = 1
        plusBtn.layer.borderColor = UIColor.init(hexCode: "#54ADFF").cgColor
        plusBtn.layer.cornerRadius = 10
        plusBtn.setTitleColor(UIColor.init(hexCode: "#54ADFF"), for: .normal)
        
        title1.font = UIFont.h2()
        title2.font = UIFont.h2()
        title3.font = UIFont.h2()
        
        title1.text = "\(UserInfo.name)님, 반가워요"
        title1.textColor = UIColor.init(hexCode: "#FAFAFA")
        title2.textColor = UIColor.init(hexCode: "#54ADFF")
        title3.textColor = UIColor.init(hexCode: "#FAFAFA")
        
        emptytitle1.font = UIFont.h4()
        emptytitle1.textColor = UIColor.init(hexCode: "#9E9E9E")
        emptytitle2.font = UIFont.body1()
        emptytitle2.textColor = UIColor.init(hexCode: "#9E9E9E")
        emptytitle3.font = UIFont.body1()
        emptytitle3.textColor = UIColor.init(hexCode: "#9E9E9E")
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
        getDayRoutine(day: dateToString(day: selectedDay))
        
        if indexPath.row == 0 {
            self.routineTable.reloadData()
            
        }
        
    }
}

extension RoutineVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        routineData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineCell", for: indexPath) as! RoutineCell
        cell.selectionStyle = .none
        
        // 루틴 정보
        cell.routineTitle.text = routineData[indexPath.row].title
        cell.routineTime.text = routineData[indexPath.row].time
        cell.tagTitle.text = routineData[indexPath.row].category == 1 ? "운동" : "독서"
        
        //
        if routineData[indexPath.row].category == 1
        {
            cell.tagView.layer.borderColor = UIColor.init(hexCode: "#54adff").cgColor
            cell.tagTitle.textColor = UIColor.init(hexCode: "#54adff")
            
        }else{
            cell.tagView.layer.borderColor = UIColor.init(hexCode: "#cf80ff").cgColor
            cell.tagTitle.textColor = UIColor.init(hexCode: "#cf80ff")
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
