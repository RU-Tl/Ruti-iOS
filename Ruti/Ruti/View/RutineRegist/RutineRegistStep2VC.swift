//
//  RutineRegistStep2.swift
//  Ruti
//
//  Created by leeyeon2 on 5/23/24.
//

import UIKit

// 루틴 등록 화면 2
class RutineRegistStep2VC: UIViewController {
    
    @IBOutlet weak var registTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var routineTextlFiled: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        hideKeyboard()
        //back label 삭제
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white  // 색상 변경
        self.navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func initUI() {
        // 텍스트 필드 포커싱
//        routineTextlFiled.becomeFirstResponder()
        
        categoryLabel.text = categoryDict[NewRoutineData.shared.categories ?? ""]
        routineTextlFiled.borderStyle = .none
        
        let border = CALayer()
        border.frame = CGRect(x: 0, y: routineTextlFiled.frame.size.height-1, width: routineTextlFiled.frame.width, height: 1)
        border.backgroundColor = UIColor(hexCode: CustomColor.Category.EXERCISE).cgColor
        routineTextlFiled.layer.addSublayer((border))
        routineTextlFiled.textAlignment = .center
        routineTextlFiled.textColor = UIColor.white
        routineTextlFiled.font = UIFont.body1()
        
        registTitle.font = UIFont.h1()
        subtitle.font = UIFont.body3()
        categoryTitle.font = UIFont.caption1()
        categoryLabel.font = UIFont.h4()
        
        //btn font
        let title = "다음"
        let btnfont = UIFont.body1()
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: btnfont]
        let attributedText = NSAttributedString(string: title, attributes: attributes)
        nextBtn.setAttributedTitle(attributedText, for: .normal)
        nextBtn.layer.cornerRadius = 10
    }
    
    // 다음 단계 전 input validate 수행
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let routineText = routineTextlFiled.text {
            if routineText.isEmpty {
                print("루틴 제목 추가 안함")
    
                AlertView.showAlert(title: "등록할 루틴 이름을 추가해주세요.",
                                    message: nil,
                                    viewController: self,
                                    dismissAction: nil)
                return false
            }
        }
        NewRoutineData.shared.content = routineTextlFiled.text
        return true
    }
    
    @IBAction func registerRoutineTitle(_ sender: Any) {
//        if ((routineTextlFiled.text?.isEmpty) != nil) {
//            AlertView.showAlert(title: "등록할 루틴 이름을 추가해주세요.",
//                                message: nil,
//                                viewController: self,
//                                dismissAction: nil)
//        }else{
//            NewRoutineData.shared.content = routineTextlFiled.text
//        }
    }
}

extension RutineRegistStep2VC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
