//
//  RutineRegistStep3VC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/23/24.
//

import UIKit

// 루틴 등록 화면 3
class RutineRegistStep3VC: UIViewController, PopupVCDelegate {

    @IBOutlet weak var registTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!

    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startDate: UILabel!
    
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    let startdateList = ["오늘", "내일", "모레"]
    let enddateList = ["30일 뒤", "60일 뒤", "100일 뒤","날짜 선택"]
    
    var selectedStartDate: Date?
    var selectedEndDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //날짜 init
        startDate.text = ""
        endDate.text = ""

        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        
        tagCollectionView2.delegate = self
        tagCollectionView2.dataSource = self
        tagCollectionView2.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
      
        initUI()
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white  // 색상 변경
        self.navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func initUI() {
        registTitle.font = UIFont.h1()
        subtitle.font = UIFont.body3()
        categoryTitle.font = UIFont.caption1()
        categoryLabel.font = UIFont.h4()
        startLabel.font = UIFont.subTitle()
        startLabel.textColor = UIColor.init(hexCode: CustomColor.white_gray)
        
        startDate.font = UIFont.subTitle()
        startDate.textColor = UIColor.init(hexCode: CustomColor.white)
        
        endLabel.font = UIFont.subTitle()
        endLabel.textColor = UIColor.init(hexCode: CustomColor.white_gray)
        
        endDate.font = UIFont.subTitle()
        endDate.textColor = UIColor.init(hexCode: CustomColor.white)
        
        //btn font
        let title = "다음"
        let btnfont = UIFont.body1()
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: btnfont]
        let attributedText = NSAttributedString(string: title, attributes: attributes)
        nextBtn.setAttributedTitle(attributedText, for: .normal)
        nextBtn.layer.cornerRadius = 10
        
        view1.addSubview(tagCollectionView)
        NSLayoutConstraint.activate([
            tagCollectionView.leadingAnchor.constraint(equalTo: view1.leadingAnchor),
            tagCollectionView.trailingAnchor.constraint(equalTo: view1.trailingAnchor),
            tagCollectionView.topAnchor.constraint(equalTo: startLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            tagCollectionView.bottomAnchor.constraint(equalTo: view1.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view2.addSubview(tagCollectionView2)
        NSLayoutConstraint.activate([
            tagCollectionView2.leadingAnchor.constraint(equalTo: view2.leadingAnchor),
            tagCollectionView2.trailingAnchor.constraint(equalTo: view2.trailingAnchor),
            tagCollectionView2.topAnchor.constraint(equalTo: endLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            tagCollectionView2.bottomAnchor.constraint(equalTo: view2.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func didDismissPopupVC(selectedDate: Date) {
        print("dismiss")
        selectedEndDate = selectedDate
    }
    
    @IBAction func registerRoutineTime(_ sender: Any) {
        let formatter = DateFormatter()
        // form : "2024-05-24"
        formatter.dateFormat = "yyyy-MM-dd"
        // null 처리
        NewRoutineData.shared.startDate = formatter.string(from: selectedStartDate ?? Date())
        NewRoutineData.shared.endDate = formatter.string(from: selectedEndDate ?? Date())
    }
    
    // MARK: - tag view
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
    
    private lazy var tagCollectionView2: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        //tag 위아래
        layout.minimumLineSpacing = 5
        //tag 좌우
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
}
extension RutineRegistStep3VC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label: UILabel = {
            let customLabel = UILabel()
            customLabel.font = UIFont.subTitle()
            if collectionView == tagCollectionView {
                customLabel.text = startdateList[indexPath.row]
                customLabel.font = UIFont.body3()
                customLabel.textColor = UIColor.init(hexCode: CustomColor.clear_white)
                
            }else if collectionView == tagCollectionView2{
                customLabel.text = enddateList[indexPath.item]
                customLabel.font = UIFont.body3()
                customLabel.textColor = UIColor.init(hexCode: CustomColor.clear_white)
            }
            customLabel.sizeToFit()
            return customLabel
        }()
        let size = label.frame.size
       
        
        if collectionView == tagCollectionView {
            return CGSize(width: size.width + 75, height: 58)
        }else if collectionView == tagCollectionView2{
            return CGSize(width: size.width + 18, height: 58)
        }
        return CGSize()
    }
}
extension RutineRegistStep3VC: UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            return startdateList.count
        }else if collectionView == tagCollectionView2{
            return enddateList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        
//        cell.backgroundColor = .white
        if collectionView == tagCollectionView {
            cell.tagLabel.text = startdateList[indexPath.row]
            
//            if cell.tagLabel.text == self.categorie {
//                collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
//                cell.isSelected = true
//            }
        }else if collectionView == tagCollectionView2{
            cell.tagLabel.text = enddateList[indexPath.row]
//            if cell.tagLabel.text == self.emotion {
//                collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
//                cell.isSelected = true
//            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let today = Date()
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        // 루틴 시작 날짜 선택
        if collectionView == tagCollectionView{
            if indexPath.row == 0 {
                // 오늘
                selectedStartDate = Date()
            }else if indexPath.row == 1 {
                // 내일
                selectedStartDate = Calendar.current.date(byAdding: .day, value: 1, to: today)
            }else if indexPath.row == 2 {
                // 모레
                selectedStartDate = Calendar.current.date(byAdding: .day, value: 2, to: today)
            }
            startDate.text = formatter.string(from: selectedStartDate!)
        }
        
        // 루틴 종료 날짜 선택
        // ["30일 뒤", "60일 뒤", "100일 뒤","날짜 선택"]
        if collectionView == tagCollectionView2{
            if indexPath.row == 0 {
                selectedEndDate = Calendar.current.date(byAdding: .day, value: 30, to: today)
            }else if indexPath.row == 1 {
                selectedEndDate = Calendar.current.date(byAdding: .day, value: 60, to: today)
            }else if indexPath.row == 2 {
                selectedEndDate = Calendar.current.date(byAdding: .day, value: 100, to: today)
            }
            else if indexPath.row == 3 {
                //날짜 선택 팝업 뷰 띄우기
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                if let popupVC = storyBoard.instantiateViewController(withIdentifier: "PopupVC") as? PopupVC{
                    popupVC.modalPresentationStyle = .overFullScreen
                    present(popupVC, animated: false, completion: nil)
                    
                    var vc2 = PopupVC()
                    vc2.popupVCDelegate = self
//                    selectedEndDate = popupVC.selectedEndDate
                }
            }
            
            if let selectedEndDate = selectedEndDate {
                endDate.text = formatter.string(from: selectedEndDate)
            }else {
                endDate.text = ""
            }
        }
    }
}



class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementCategory == .cell {
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
        }
        return attributes
    }
}
