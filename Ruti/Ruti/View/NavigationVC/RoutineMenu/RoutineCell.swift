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
        baseView.backgroundColor = UIColor.init(hexCode: "#3E3E3E")
        baseView.layer.borderColor = UIColor.init(hexCode: "#111111").cgColor
        baseView.layer.borderWidth = 1
        
        routineTitle.font = UIFont.body1()
        routineTime.font = UIFont.caption1()
        routineTitle.textColor = UIColor.init(hexCode: "#fafafa")
        routineTime.textColor = UIColor.init(hexCode: "#fafafa")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
