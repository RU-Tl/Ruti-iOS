//
//  RutineRegistStep4VC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/23/24.
//

import UIKit

class RutineRegistStep4VC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        cell.tagLabel.text = dayList[indexPath.row]
        return cell
    }
    
    @IBOutlet weak var registTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    let dayList = ["일", "월", "화", "수", "목", "금", "토"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        initUI()
    }
    
    private lazy var tagCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        
        //tag 좌우
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    @IBAction func dateAction(_ sender: Any) {
        changed()
    }
    
    // 시간 출력
    func changed() {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .full
        dateformatter.timeStyle = .full
    }
    
    func initUI() {
        registTitle.font = UIFont.h1()
        subtitle.font = UIFont.body3()
        categoryTitle.font = UIFont.caption1()
        categoryLabel.font = UIFont.h4()
        timePicker.setValue(UIColor.white, forKeyPath: "textColor")
        //btn font
        let title = "루틴 등록하기"
        let btnfont = UIFont.body1()
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: btnfont]
        let attributedText = NSAttributedString(string: title, attributes: attributes)
        nextBtn.setAttributedTitle(attributedText, for: .normal)
        nextBtn.layer.cornerRadius = 10
        
        view1.addSubview(tagCollectionView)
        NSLayoutConstraint.activate([
            tagCollectionView.leadingAnchor.constraint(equalTo: view1.leadingAnchor),
            tagCollectionView.trailingAnchor.constraint(equalTo: view1.trailingAnchor),
            tagCollectionView.topAnchor.constraint(equalTo: view1.safeAreaLayoutGuide.bottomAnchor),
            tagCollectionView.bottomAnchor.constraint(equalTo: view1.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension RutineRegistStep4VC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label: UILabel = {
            let customLabel = UILabel()
            customLabel.font = UIFont.subTitle()
            if collectionView == tagCollectionView {
                customLabel.text = dayList[indexPath.row]
                customLabel.font = UIFont.body3()
                customLabel.textColor = UIColor.init(hexCode: "#FFFFFF")
            }
            customLabel.sizeToFit()
            return customLabel
        }()
        let size = label.frame.size
       
        if collectionView == tagCollectionView {
            return CGSize(width:  15, height: 20)
//            return CGSize(width: size.width + 15, height: 20)
        }
        return CGSize()
    }
}


