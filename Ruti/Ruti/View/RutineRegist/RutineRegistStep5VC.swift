//
//  RutineRegistStep5VC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/23/24.
//

import UIKit

class RutineRegistStep5VC: UIViewController {
    
    @IBOutlet weak var registTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    func initUI() {
        registTitle.font = UIFont.h1()
        subtitle.font = UIFont.h4()


        //btn font
        let title = "루틴 확인하기"
        let btnfont = UIFont.body1()
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: btnfont]
        let attributedText = NSAttributedString(string: title, attributes: attributes)
        nextBtn.setAttributedTitle(attributedText, for: .normal)
        nextBtn.layer.cornerRadius = 10
    }
}
