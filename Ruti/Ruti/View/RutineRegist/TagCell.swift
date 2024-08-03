//
//  TagCell.swift
//  Ruti
//
//  Created by leeyeon2 on 5/23/24.
//
import UIKit

class TagCell: UICollectionViewCell {
    
    static let identifier = "TagCell"
    
    // MARK: - View
    let tagLabel: UILabel = {
        let customUILabel = UILabel()
        customUILabel.font = UIFont.body3()
        customUILabel.textColor = UIColor.init(hexCode: CustomColor.clear_white)
        customUILabel.isUserInteractionEnabled = false
        customUILabel.translatesAutoresizingMaskIntoConstraints = false
        return customUILabel
    }()
    
    override var isSelected: Bool {
      didSet {
        if isSelected {
            layer.borderWidth = 1
            layer.borderColor = UIColor(hexCode: CustomColor.Category.EXERCISE).cgColor
        } else {
            layer.borderWidth = 1
            layer.borderColor = UIColor(hexCode: CustomColor.dark_gray).cgColor
        }
      }
    }
    
    // MARK: - layout
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor(hexCode: CustomColor.dark_gray).cgColor
        backgroundColor = .clear
        addSubview(tagLabel)
        setConstraint()
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            tagLabel.centerXAnchor.constraint(equalTo:
                                                self.centerXAnchor),
            tagLabel.centerYAnchor.constraint(equalTo:
                                                self.centerYAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
