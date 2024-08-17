//
//  RutineRegistStep4VC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/23/24.
//

import UIKit
import Alamofire

// 루틴 등록 화면 4
class RutineRegistStep4VC: UIViewController {
    
    @IBOutlet weak var registTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    let dayList = ["일", "월", "화", "수", "목", "금", "토"]
    var selectedDayList: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        tagCollectionView.allowsMultipleSelection = true
        initUI()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white  // 색상 변경
        self.navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.setNavigationBarHidden(false, animated: true)
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
    
    @IBAction func dateAction(_ sender: Any) {
        changed()
    }
    
    // 루틴 등록 버튼
    @IBAction func rutineRegistAction(_ sender: Any) {
        // 1. 요일 input validate
        // >> 서버 리팩토링 이후 추가
//        if selectedDayList.count < 1 {
//            AlertView.showAlert(title: "루틴을 반복할 요일을 선택해주세요.",
//                                message: nil,
//                                viewController: self,
//                                dismissAction: nil)
//        } else {
            //2. 시간 input validate - "AM 7:20"
            let selectedAlarmTime = timePicker.date
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "a h:mm"
            NewRoutineData.shared.alarmTime = formatter.string(from: selectedAlarmTime)
            
            // NW Request
            let routineParameter: Parameters = [ "categories" : NewRoutineData.shared.categories!,
                                                 "content" : NewRoutineData.shared.content!,
                                                 "startDate" : NewRoutineData.shared.startDate!,
                                                 "endDate" : NewRoutineData.shared.endDate!,
                                                 "alarmTime" : NewRoutineData.shared.alarmTime!]
            
            let request = APIRequest(method: .post,
                                     path: "/routine/\(UserInfo.memberId)",
                                     param: routineParameter,
                                     headers: APIConfig.authHeaders)
            
            APIService.shared.perform(request: request,
                                      completion: { (result) in
                switch result {
                case .success(let data):
                    if let data = data.body["data"] as? [String:Any]{
                        if let routineId = data["routineId"] as? Int{
                            print(routineId)
                            self.performSegue(withIdentifier: "registerComplete", sender: sender)
                        }
                    }
                case .failure:
                    print(APIError.networkFailed)
                    AlertView.showAlert(title: "루틴이 등록되지 않았습니다.",
                                        message: nil,
                                        viewController: self,
                                        dismissAction: nil)
                }
            })
//        }
    }
    
    // 시간 출력
    func changed() {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .full
        dateformatter.timeStyle = .full
    }
    
    func initUI() {
        registTitle.font = UIFont.h1()
        subtitle.font = UIFont.body3()
        categoryTitle.font = UIFont.caption1()
        categoryLabel.font = UIFont.h4()
        timePicker.setValue(UIColor.white, forKeyPath: "textColor")
        categoryLabel.text = categoryDict[NewRoutineData.shared.categories ?? ""]
        
        //btn font
        let title = "루틴 등록하기"
        let btnfont = UIFont.body1()
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: btnfont]
        let attributedText = NSAttributedString(string: title, attributes: attributes)
        nextBtn.setAttributedTitle(attributedText, for: .normal)
        nextBtn.layer.cornerRadius = 10
        
        view1.addSubview(tagCollectionView)
        NSLayoutConstraint.activate([
            tagCollectionView.leadingAnchor.constraint(equalTo: view1.leadingAnchor),
            tagCollectionView.trailingAnchor.constraint(equalTo: view1.trailingAnchor),
            tagCollectionView.topAnchor.constraint(equalTo: view1.safeAreaLayoutGuide.topAnchor),
            tagCollectionView.bottomAnchor.constraint(equalTo: view1.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension RutineRegistStep4VC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        cell.tagLabel.text = dayList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


extension RutineRegistStep4VC: UICollectionViewDelegateFlowLayout {
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
        
        if collectionView == tagCollectionView {
            //            return CGSize(width:  15, height: 20)
            return CGSize(width: 40, height: 40)
        }
        return CGSize()
    }
}
