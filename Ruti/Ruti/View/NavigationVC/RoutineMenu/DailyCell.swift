//
//  DailyCell.swift
//  Ruti
//
//  Created by leeyeon2 on 5/25/24.
//

import UIKit

class DailyCell: UICollectionViewCell {
    static let identifier = "DailyCell"
    
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    
    override var isSelected: Bool {
      didSet {
        if isSelected {
            dayLabel.textColor = UIColor.init(hexCode: CustomColor.light_blue)
            topLineView.isHidden = false
        } else {
            dayLabel.textColor = UIColor.init(hexCode: CustomColor.light_gray)
            topLineView.isHidden = true
        }
      }
    }
}
