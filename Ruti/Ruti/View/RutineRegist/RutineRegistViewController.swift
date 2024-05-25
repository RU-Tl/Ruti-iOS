//
//  RutineRegistViewController.swift
//  Ruti
//
//  Created by leeyeon2 on 5/23/24.
//

import UIKit

class RutineRegistViewController: UIViewController {
    
    @IBOutlet weak var categoryTable: UITableView!
    @IBOutlet weak var registTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    let categoryList = ["건강 지키는, 운동", "마음의 양식, 독서", "끝 없는, 자기계발"]
    let categoryList2 = ["운동", "독서", "자기계발"]
    let SettingValues = [UserInfo.name, UserInfo.email, ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white  // 색상 변경
        self.navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func initUI() {
        categoryTable.backgroundColor = .clear
        registTitle.font = UIFont.h1()
        subtitle.font = UIFont.body3()
        let healthTitle = "건강 지키는, 운동"
        let rTitle = "마음의 양식, 독서"
        let dTitle = "끝 없는, 자기계발"
        
//        //btn font
//        let btnfont = UIFont.h3()
//        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: btnfont]
//        let attributedText = NSAttributedString(string: healthTitle, attributes: attributes)
//        healthBtn.setAttributedTitle(attributedText, for: .normal)
//        
//        let attributedText2 = NSAttributedString(string: rTitle, attributes: attributes)
//        readingBtn.setAttributedTitle(attributedText2, for: .normal)
//        
//        let attributedText3 = NSAttributedString(string: dTitle, attributes: attributes)
//        developBtn.setAttributedTitle(attributedText3, for: .normal)
//        
//        healthBtn.layer.cornerRadius = 10
//        readingBtn.layer.cornerRadius = 10
//        developBtn.layer.cornerRadius = 10
//        
//        //            .setTitleColor(.black, for: .selected)
//        healthBtn.setBackgroundColor(UIColor.blue, for: .selected)
//        
//        readingBtn.setBackgroundColor(UIColor.blue, for: .selected)
//        //        config.background.strokeColor = UIColor.red
//        //        config.background.strokeWidth = 3
//        
//        let config = UIButton.Configuration.filled()
//        
//        let handler: UIButton.ConfigurationUpdateHandler = { button in
//            switch button.state {
//            case [.selected, .highlighted]:
//                button.configuration?.baseBackgroundColor = UIColor.blue
//            case .selected:
//                button.configuration?.title = "Selected"
//            case .highlighted:
//                button.configuration?.baseBackgroundColor = UIColor.blue
//                button.configuration?.title = "Highlighted"
//            case .disabled:
//                button.configuration?.title = "Disabled"
//            default:
//                button.configuration?.title = "Normal"
//                button.configuration?.baseBackgroundColor = UIColor.black
//            }
//        }
//        
//        healthBtn.configuration = config
//        healthBtn.configurationUpdateHandler = handler
//        
        
    }
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(backgroundImage, for: state)
    }
}

extension UIColor {
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

extension RutineRegistViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        cell.selectionStyle = .none
        cell.categoryTitle.text = categoryList[indexPath.row]
        cell.categoryTitle.font = UIFont.h4()
        cell.categoryTitle.textColor = UIColor.init(hexCode: "#FAFAFA")

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell {
            cell.contentView.backgroundColor = .white
            cell.baseView.backgroundColor = .white
        }
        
        if let boardVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistView") as? RutineRegistStep2VC{
            self.navigationController?.pushViewController(boardVC, animated: true)
            boardVC.selectedCategory = categoryList2[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

    }
}
