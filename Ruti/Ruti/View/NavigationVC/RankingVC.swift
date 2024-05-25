//
//  RankingVC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/24/24.
//

import UIKit
import FSPagerView
import SnapKit

class RankingVC: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    let category = ["운동 랭킹 TOP 10", "독서 랭킹 TOP 10", "자기계발 랭킹 TOP 10"]

    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet{
            self.pagerView.register(MainPagerViewCell.self, forCellWithReuseIdentifier: MainPagerViewCell.description())
            
//            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            //아이템 크기 설정
//            self.myPagerView.itemSize = FSPagerView.automaticSize
            //무한스크롤 설정
//            self.myPagerView.isInfinite = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
        
        title1.font = UIFont.h2()
        title2.font = UIFont.h2()
        title1.textColor = UIColor.init(hexCode: "#FAFAFA")
        title2.textColor = UIColor.init(hexCode: "#FAFAFA")
        
        self.title1.text = "이용님, 이번 달 카테고리별로"
        guard let text = self.title1.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.init(hexCode: "#CF80FF"), range: (text as NSString).range(of: "카테고리"))
        self.title1.attributedText = attributeString

        settingPagerView()
        
    }
    
    // 아이템의 개수
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return category.count
    }
    
    // 셀 설정
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: MainPagerViewCell.description(), at: index) as? MainPagerViewCell else { return FSPagerViewCell() }
        cell.designCell("독서 랭킹 TOP 10")
        return cell
    }
    
    // 선택 막기
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    
    // 다음 아이템으로 넘어갔을 때
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView) {
//        self.title1.text = "이용님, 이번 달 카테고리별로"
//        guard let text = self.title1.text else { return }
//        let attributeString = NSMutableAttributedString(string: text)
//        attributeString.addAttribute(.foregroundColor, value: UIColor.init(hexCode: "#CF80FF"), range: (text as NSString).range(of: "카테고리"))
//        self.title1.attributedText = attributeString
    }

    func settingPagerView() {
        pagerView.register(MainPagerViewCell.self, forCellWithReuseIdentifier: MainPagerViewCell.description())
        pagerView.transformer = FSPagerViewTransformer(type: .linear)

        let bounds = UIScreen.main.bounds
        pagerView.itemSize = CGSize(
            width: self.pagerView.frame.width * 0.80,
            height: self.pagerView.frame.height * 0.80
        )
        pagerView.interitemSpacing = 20
    }
}

class MainPagerViewCell: FSPagerViewCell, UITableViewDelegate, UITableViewDataSource {
    let numberList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    let nicknameList = ["이용", "이용","이용","이용","이용","이용","이용","이용","이용","이용"]
    let countList = ["111", "111","111","111","111","111","111","111","111","111"]
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingTableCell", for: indexPath) as! RankingTableCell
        
        cell.numberLabel.font = UIFont.caption1()
        cell.nicknameLabel.font = UIFont.caption1()
        cell.countLabel.font = UIFont.caption1()
        
        cell.numberLabel.text = numberList[indexPath.row]
        cell.nicknameLabel.text = nicknameList[indexPath.row]
        cell.countLabel.text = countList[indexPath.row]
        
        if indexPath.row%2 == 0{
            cell.contentView.backgroundColor = UIColor.init(hexCode: "#333333")
        }else{
            cell.contentView.backgroundColor = UIColor.init(hexCode: "#3E3E3E")
        }
        
        if indexPath.row == 3{
            //자기 랭킹
            cell.numberLabel.textColor = UIColor.init(hexCode: "#333333")
            cell.nicknameLabel.textColor = UIColor.init(hexCode: "#333333")
            cell.countLabel.textColor = UIColor.init(hexCode: "#333333")
            cell.numberLabel.font = UIFont.body4()
            cell.nicknameLabel.font = UIFont.body4()
            cell.countLabel.font = UIFont.body4()
            //독서
            cell.contentView.backgroundColor = UIColor.init(hexCode: "#CF80FF")
//            cell.contentView.layer.cornerRadius = 5
        }else{
            cell.numberLabel.textColor = UIColor.init(hexCode: "#FAFAFA")
            cell.nicknameLabel.textColor = UIColor.init(hexCode: "#FAFAFA")
            cell.countLabel.textColor = UIColor.init(hexCode: "#FAFAFA")
        }
        
        return cell
    }
    
    let titleLabel: UILabel = {
        let labele = UILabel()
        labele.font = UIFont.h4()
        labele.textColor = UIColor.init(hexCode: "#FAFAFA")
        return labele
    }()
    
    private let rankTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = UIColor.init(hexCode: "#3E3E3E")
        tableview.layer.cornerRadius = 5
        return tableview
    }()
    
    private let label: UILabel = {
        let label = UILabel()
//        label.text = "상어상어"
//        label.textColor = UIColor.gray
        return label

    }()
    
    override func prepareForReuse() {
        // 기본 imageView를 언제든지 커스텀 상태로 유지시킨다
//        self.imageView?.contentMode = .scaleAspectFit
//        self.imageView?.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(self).inset(12)
//            make.height.equalTo(imageView!.snp.width)
//        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexCode: "#3E3E3E")
        rankTableView.delegate = self
        rankTableView.dataSource = self
        let nib = UINib(nibName: "RankingTableCell", bundle: nil)
        rankTableView.register(nib, forCellReuseIdentifier: "RankingTableCell")
        
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.init(hexCode: "#BDBDBD").cgColor
        self.layer.borderWidth = 1
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        
        addSubview(rankTableView)
        rankTableView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func designCell(_ sender: String) {

        titleLabel.text = sender
//        artistLabel.text = sender.artist
//        
//        recordLabel.text = (sender.count > 1) ? "\(sender.count) records" : "\(sender.count) record"
//        
//        // ( 두 번째 인덱스 제외 ("음악") )
//        for (index, item) in [genre1Label, genre2Label, genre3Label].enumerated() {
//            item.isHidden = false
//            
//            var genreIdx = index
//            if index >= 1 {
//                genreIdx = index + 1
//            }
//            
//            if genreIdx <= sender.genres.count - 1 {
//                item.text = sender.genres[genreIdx]
//            } else {
//                item.isHidden = true
//            }
//        }
    }
}

