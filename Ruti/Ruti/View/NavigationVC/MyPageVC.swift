//
//  MyPageVC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/24/24.
//

import UIKit

class MyPageVC: UIViewController {
    @IBOutlet weak var nameLabel2: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imgBaseView: UIView!
    @IBOutlet weak var raceView: UIView!
    
    @IBOutlet weak var racetitle1: UILabel!
    @IBOutlet weak var racetitle2: UILabel!
    
    @IBOutlet weak var progressBase: UIView!
    @IBOutlet weak var progressBar: UIView!
    
    @IBOutlet weak var lv1: UILabel!
    @IBOutlet weak var lv2: UILabel!
    @IBOutlet weak var lv3: UILabel!
    @IBOutlet weak var lv4: UILabel!
    
    @IBOutlet weak var 로그인타입: UILabel!
    @IBOutlet weak var myPageTable: UITableView!
    
    var race = 30
    var level = "루티니"
    var levelList = ["루꼬미", "루티니", "루틴 달인", "루틴 만렙"]
    var socialType = "카카오"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    func setUI() {
        nameLabel.text = "\(UserInfo.name)"
        racetitle1.text = "루틴 달성률 상위 \(race)%의"
        racetitle2.text = "\(level)에요!"
        
        guard let text = self.racetitle2.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.init(hexCode: CustomColor.Category.DEVELOPMENT), range: (text as NSString).range(of: "\(level)"))
        self.racetitle2.attributedText = attributeString
        
        로그인타입.text = "\(socialType)로 로그인 하셨어요"
        guard let text = self.로그인타입.text else { return }
        let attributeString2 = NSMutableAttributedString(string: text)
        attributeString2.addAttribute(.foregroundColor, value: UIColor.init(hexCode: CustomColor.kakao), range: (text as NSString).range(of: "\(socialType)"))
        self.로그인타입.attributedText = attributeString2
        
        lv1.text = levelList[0]
        lv2.text = levelList[1]
        lv3.text = levelList[2]
        lv4.text = levelList[3]
        
        nameLabel.font = UIFont.body1()
        nameLabel2.font = UIFont.body1()
        racetitle1.font = UIFont.body1()
        racetitle2.font = UIFont.body1()
        
        lv1.font = UIFont.caption1()
        lv2.font = UIFont.caption1()
        lv3.font = UIFont.caption1()
        lv4.font = UIFont.caption1()
        
        로그인타입.font = UIFont.caption1()
        imgBaseView.layer.cornerRadius = 50
        imgBaseView.backgroundColor = .clear
        imgBaseView.layer.borderWidth = 1
        imgBaseView.layer.borderColor = UIColor(hexCode: CustomColor.light_blue).cgColor
        raceView.layer.cornerRadius = 15
        raceView.layer.borderWidth = 1
        raceView.layer.borderColor = UIColor.black.cgColor
        progressBase.layer.cornerRadius = 5
        progressBar.layer.cornerRadius = 5
    }
}

extension MyPageVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var alert = UIAlertController()
        
        // 1. 루틴 알림 설정
        if(indexPath.row == 0){
            guard
                let settingURL = URL(string: UIApplication.openSettingsURLString),
                UIApplication.shared.canOpenURL(settingURL)
            else { return }
            UIApplication.shared.open(settingURL, options: [:])
        }else if(indexPath.row == 1){
            // 2. 로그아웃
            alert = UIAlertController(title:"로그아웃 하시겠습니까?",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.alert)
            self.present(alert,animated: true,completion: nil)
            let actionCancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            let actionConfirm = UIAlertAction(title: "확인", style: .default, handler: {_ in
                UIViewController.changeRootVCToSignIn()
            })
            alert.addAction(actionConfirm)
            alert.addAction(actionCancel)
        }else{
            // 3. 계정 삭제
            // 로그인 화면(SignInViewController) 으로 이동
            alert = UIAlertController(title:"계정 탈퇴하시겠습니까?",
                                      message: "지난 루틴 기록이 모두 사라집니다.",
                                      preferredStyle: UIAlertController.Style.alert)
            self.present(alert,animated: true,completion: nil)
            
            let actionConfirm = UIAlertAction(title: "확인", style: .default, handler: {_ in
                //
                let request = APIRequest(method: .delete,
                                         path: "/member" + "/\(UserInfo.memberId)",
                                         param: nil,
                                         headers: APIConfig.authHeaders)
                APIService.shared.perform(request: request,
                                          completion: { [self] (result) in
                    AlertView.showAlert(title: "회원 탈퇴가 완료되었습니다.",
                                        message: "로그인 화면으로 이동합니다.",
                                        viewController: self,
                                        dismissAction: self.deleteAccountMenu)
                })
            })
            let actionCancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            
            alert.addAction(actionConfirm)
            alert.addAction(actionCancel)
        }
    }
    
    func deleteAccountMenu() {
        //UserInfo data init
        
        //Userdefalut 삭제
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        //로그인 화면 이동
        UIViewController.changeRootVCToSignIn()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell")!
        
        cell.textLabel?.font = UIFont.body3()
        if(indexPath.row == 0){
            cell.textLabel?.text = "루틴 알림 설정"
        }else if(indexPath.row == 1){
            cell.textLabel?.text = "로그아웃"
        }else{
            cell.textLabel?.text = "계정 삭제"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
