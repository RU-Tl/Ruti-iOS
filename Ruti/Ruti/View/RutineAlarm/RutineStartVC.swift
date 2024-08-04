//
//  RutineStartVC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/24/24.
//

import UIKit
import FSPagerView

class RutineStartVC: UIViewController {
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var title2: UILabel!
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pendingBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    @IBAction func test(_ sender: Any) {
        pendingBtn.setTitleColor(.red, for: .selected)
    }
    
    // 버튼 클릭 시 색상 변경
    @IBAction func startBtnAction(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor == UIColor.red ? UIColor.red : UIColor.green
    }
    
    @IBAction func pendingBtnAction(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor == UIColor.red ? UIColor.red : UIColor.green
    }
    
    @IBAction func stopBtnAction(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor == UIColor.red ? UIColor.red : UIColor.green
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.setNavigationBarHidden(true, animated: true)

        title1.font = UIFont.h2()
        subtitle.font = UIFont.h2()
        title2.font = UIFont.h2()
        
        title1.textColor = UIColor.init(hexCode: CustomColor.Category.EXERCISE)
        subtitle.textColor = UIColor.init(hexCode: CustomColor.white)
        title2.textColor = UIColor.init(hexCode: CustomColor.white)

        let l1 = "네, 지금 시작할게요!"
        let l2 = "잠시 미룰게요"
        let l3 = "오늘은 어려워요"
        
        let btnfont = UIFont.h4()
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: btnfont]
        
        let attributedText = NSAttributedString(string: l1, attributes: attributes)
        startBtn.setAttributedTitle(attributedText, for: .normal)

        let attributedText2 = NSAttributedString(string: l2, attributes: attributes)
        pendingBtn.setAttributedTitle(attributedText2, for: .normal)
        
        let attributedText3 = NSAttributedString(string: l3, attributes: attributes)
        stopBtn.setAttributedTitle(attributedText3, for: .normal)
        
        startBtn.layer.cornerRadius = 10
        startBtn.layer.borderWidth = 1
        startBtn.layer.borderColor = UIColor.init(hexCode: CustomColor.dark_gray).cgColor

        pendingBtn.layer.cornerRadius = 10
        pendingBtn.layer.borderWidth = 1
        pendingBtn.layer.borderColor = UIColor.init(hexCode: CustomColor.dark_gray).cgColor
        
        stopBtn.layer.cornerRadius = 10
        stopBtn.layer.borderWidth = 1
        stopBtn.layer.borderColor = UIColor.init(hexCode: CustomColor.dark_gray).cgColor
    }
}
