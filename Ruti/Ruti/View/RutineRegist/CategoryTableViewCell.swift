//
//  CategoryTableViewCell.swift
//  Ruti
//
//  Created by leeyeon2 on 5/23/24.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        baseView.layer.cornerRadius = 10
        baseView.layer.borderColor = UIColor.init(hexCode: "#757575").cgColor
        baseView.layer.borderWidth = 1
        categoryImg.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
