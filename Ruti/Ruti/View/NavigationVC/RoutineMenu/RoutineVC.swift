//
//  RoutineVC.swift
//  Ruti
//
//  Created by leeyeon2 on 5/24/24.
//

import UIKit

class RoutineVC: UIViewController {
    let dayList = ["20 월", "21 화", "22 수", "23 목", "24 금", "25 토","26 일"]
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title3: UILabel!
    
    @IBOutlet weak var weekView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @IBAction func plusBtn(_ sender: Any) {
    }
    
    @IBOutlet weak var routineTable: UITableView!
    
    
    func initUI() {
        title1.font = UIFont.h2()
        title2.font = UIFont.h2()
        title3.font = UIFont.h2()
        title1.textColor = UIColor.init(hexCode: "#FAFAFA")
        title2.textColor = UIColor.init(hexCode: "#54ADFF")
        title3.textColor = UIColor.init(hexCode: "#FAFAFA")
//        let layout = UICollectionViewFlowLayout()
//
//        weekView.setCollectionViewLayout(layout, animated: true)
//        
    }
}
extension RoutineVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCell.identifier, for: indexPath) as? DailyCell else {
            return UICollectionViewCell()
        }
        
        cell.dayLabel.text = dayList[indexPath.row]
        cell.dayLabel.font = UIFont.body4()
        cell.dayLabel.textColor = UIColor.init(hexCode: "#9E9E9E")
        cell.topLineView.isHidden = true
        if indexPath.row == 6 {
            cell.dayLabel.textColor = UIColor.init(hexCode: "#B5DCFF")
            cell.topLineView.isHidden = false
        }
            
        return cell
    }
}

extension RoutineVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineCell", for: indexPath) as! RoutineCell
        return cell
        
    }
}
