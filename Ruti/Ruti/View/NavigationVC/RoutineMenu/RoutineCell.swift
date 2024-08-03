//
//  RoutineCell.swift
//  Ruti
//
//  Created by leeyeon2 on 5/25/24.
//

import UIKit

class RoutineCell: UITableViewCell {

    @IBOutlet weak var tagTitle: UILabel!
    @IBOutlet weak var tagView: UIView!
    
    @IBOutlet weak var routineTitle: UILabel!
    @IBOutlet weak var routineTime: UILabel!
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var routineCheckImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagView.layer.cornerRadius = 13
        tagView.layer.borderWidth = 1
        tagView.backgroundColor = .clear

        tagTitle.font = UIFont.caption1()
       
        baseView.layer.cornerRadius = 10
        baseView.backgroundColor = UIColor.init(hexCode: CustomColor.deep_dark_gray)
//        baseView.backgroundColor = UIColor.red
        baseView.layer.borderColor = UIColor.init(hexCode: CustomColor.black).cgColor
        baseView.layer.borderWidth = 1
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.systemYellow
        selectedBackgroundView = backgroundView
        
        routineTitle.font = UIFont.body1()
        routineTime.font = UIFont.caption1()
        routineTitle.textColor = UIColor.init(hexCode: CustomColor.white)
        routineTime.textColor = UIColor.init(hexCode: CustomColor.white)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
