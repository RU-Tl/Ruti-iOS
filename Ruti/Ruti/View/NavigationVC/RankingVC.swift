//
//  RankingVC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/24/24.
//

import UIKit
import FSPagerView
import SnapKit
import Alamofire

class RankingVC: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    let category = ["운동 랭킹 TOP 10", "독서 랭킹 TOP 10", "자기계발 랭킹 TOP 10"]
    var exerciseRank = [String]()
    var readingRank = [String]()
    var developmentRank = [String]()
    
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

        //READING
        //DEVELOPMENT
        let parameter: Parameters = [
            "memberId" : UserInfo.memberId,
            "routineCate" : "EXERCISE"
        ]
        
        let request = APIRequest(method: .get,
                                 path: "/routine/\(UserInfo.memberId)/2024-06-10",
                                 param: nil,
                                 headers: APIConfig.authHeaders)
        
        APIService.shared.perform(request: request,
                                  completion: { [self] (result) in
            switch result {
            case .success(let data):
                if let data = data.body["data"] as? [[String:Any]] {
                    for list in data {
                        exerciseRank.append(list["nickname"] as! String)
                    }
                }
            case .failure:
                print(APIError.networkFailed)
            }
        })
        
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
        
        title1.font = UIFont.h2()
        title2.font = UIFont.h2()
        title1.textColor = UIColor.init(hexCode: CustomColor.white)
        title2.textColor = UIColor.init(hexCode: CustomColor.white)
        
        self.title1.text = "\(UserInfo.name)님, 이번 달 카테고리별로"
        guard let text = self.title1.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.init(hexCode: CustomColor.Category.READING), range: (text as NSString).range(of: "카테고리"))
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
        
        if index == 0{
            cell.num = 5
            cell.nicknameList = ["안이연", "유일선","김지호","김영한","이연","규빈","박주희","박건우","박성우","안지용"]
            cell.countList = ["360", "324","311","298","278","264","250","211","111","90"]
            cell.cellColor = UIColor.init(hexCode: CustomColor.Category.EXERCISE)
            cell.designCell(category[index])
            
        }else if index == 1 {
            cell.num = 2
            cell.nicknameList = ["조화진", "차은우", "규빈","한소현","안지용","김지호","박지호","원빈","김동현","안지용"]
            cell.countList = ["323", "320","311","280","228","211","198","140","132","95"]
            cell.cellColor = UIColor.init(hexCode: CustomColor.Category.READING)
            cell.designCell(category[index])
            
        }else if index == 2{
            cell.num = 4
            cell.nicknameList = ["김지호", "박지호","안지용","한소현","규빈","홍길동","김동현","황영호","안지용","박하현"]
            cell.countList = ["281", "274","231","201","190","110","99","50","45","30"]
            cell.cellColor = UIColor.init(hexCode: CustomColor.Category.DEVELOPMENT)
            cell.designCell(category[index])
        }

        return cell
    }
    
    // 선택 막기
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    
    // 다음 페이징으로 넘어갔을 때
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView) {

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
    var num: Int?
    var cellColor: UIColor?
    
    let titleLabel: UILabel = {
        let labele = UILabel()
        labele.font = UIFont.h4()
        labele.textColor = UIColor.init(hexCode: CustomColor.white)
        return labele
    }()
    
    let rankTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = UIColor.init(hexCode: CustomColor.deep_dark_gray)
        tableview.layer.cornerRadius = 5
        return tableview
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexCode: CustomColor.deep_dark_gray)
        rankTableView.delegate = self
        rankTableView.dataSource = self
        let nib = UINib(nibName: "RankingTableCell", bundle: nil)
        rankTableView.register(nib, forCellReuseIdentifier: "RankingTableCell")
        
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.init(hexCode: CustomColor.white_gray).cgColor
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
    }
    

    var numberList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    var nicknameList = ["김지호", "박지호","이규빈","한소현","조화진","홍길동","김동현","황영호","안지용","박하현"]
    var countList = ["360", "324","311","298","278","264","250","211","111","90"]

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
            cell.contentView.backgroundColor = UIColor.init(hexCode: CustomColor.black_gray)
        }else{
            cell.contentView.backgroundColor = UIColor.init(hexCode: CustomColor.deep_dark_gray)
        }
        
        if indexPath.row == num{
            //자기 랭킹
            cell.numberLabel.textColor = UIColor.init(hexCode: CustomColor.black_gray)
            cell.nicknameLabel.textColor = UIColor.init(hexCode: CustomColor.black_gray)
            cell.countLabel.textColor = UIColor.init(hexCode: CustomColor.black_gray)
            cell.numberLabel.font = UIFont.body4()
            cell.nicknameLabel.font = UIFont.body4()
            cell.countLabel.font = UIFont.body4()
            //독서
            cell.contentView.backgroundColor = cellColor
            //추후 적용
            //            cell.contentView.layer.cornerRadius = 5
        }else{
            cell.numberLabel.textColor = UIColor.init(hexCode: CustomColor.white)
            cell.nicknameLabel.textColor = UIColor.init(hexCode: CustomColor.white)
            cell.countLabel.textColor = UIColor.init(hexCode: CustomColor.white)
        }
        

        return cell
    }
    
}

