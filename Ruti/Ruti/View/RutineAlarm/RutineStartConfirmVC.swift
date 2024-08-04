//
//  RutineStartConfirmVC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/25/24.
//

import UIKit

class RutineStartConfirmVC: UIViewController {

    @IBOutlet weak var t1: UILabel!
    @IBOutlet weak var t2: UILabel!
    @IBOutlet weak var t3: UILabel!
    
    @IBOutlet weak var rimg: UIImageView!
    
    @IBOutlet weak var confirmBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        t1.font = UIFont.h2()
        t2.font = UIFont.h4()
        t3.font = UIFont.h4()
        
        t1.textColor = UIColor.init(hexCode: CustomColor.white)
        guard let text = self.t1.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.init(hexCode: CustomColor.Category.EXERCISE), range: (text as NSString).range(of: "루틴"))
        self.t1.attributedText = attributeString
        
        t2.textColor = UIColor.init(hexCode: CustomColor.white)
        t3.textColor = UIColor.init(hexCode: CustomColor.white)
        
        confirmBtn.layer.cornerRadius = 10
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
