//
//  RoutineDetailVC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/25/24.
//

import UIKit

class RoutineDetailVC: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    var categoryType: Int?
    //1 운동 2 독서
    override func viewDidLoad() {
        super.viewDidLoad()

        if categoryType == 1 {
            imgView.image = UIImage(named: "Group 48")
        }else {
            imgView.image = UIImage(named: "Group 49")
        }
    }
}
