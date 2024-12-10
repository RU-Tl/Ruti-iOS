//
//  RutineRegistStep5VC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/23/24.
//

import UIKit

// 루틴 등록 화면 5
// push 알림 등록
class RutineRegistStep5VC: UIViewController {
    
    @IBOutlet weak var registTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var subtitle2: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        self.dismiss(animated: true)
        if let boardVC = self.storyboard?.instantiateViewController(withIdentifier: "RoutineVC") as? RoutineVC{
            // 루틴 테이블 데이터 reload
            
            //            boardVC.routineData.append(RoutineData(category: 2, title: "취침 전 책 읽기", time: "PM 12:30"))
            //            boardVC.routineTable?.reloadData()
            
        }
        
        

        LocalNotificationHelper
            .shared
            .pushReservedNotification(title: "루틴을 시작할 시간이에요",
                                      body: "시작인 반인 루틴 형성, 오늘도 화이팅이에요!",
//                                      trigger: triggerDate,
                                      identifier: "RESERVED_NOTI")

    }
    

    func initUI() {
        registTitle.font = UIFont.h1()
        subtitle.font = UIFont.h4()
        subtitle2.font = UIFont.h4()
        
        //btn font
        let title = "루틴 확인하기"
        let btnfont = UIFont.body1()
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: btnfont]
        let attributedText = NSAttributedString(string: title, attributes: attributes)
        nextBtn.setAttributedTitle(attributedText, for: .normal)
        nextBtn.layer.cornerRadius = 10
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
