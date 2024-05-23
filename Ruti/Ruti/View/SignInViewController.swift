//
//  SignInViewController.swift
//  Ruti
//
//  Created by leeyeon2 on 5/23/24.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        text1.font = UIFont.h3()
        text2.font = UIFont.body2()
        let image = UIImage(named: "logo_kakao")?.imageWith(newSize: .init(width: 30, height: 30))
        signInBtn.setImage(image, for: .normal)
        signInBtn.configuration?.imagePadding = 20
    }
}

extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        return image.withRenderingMode(renderingMode)
    }
}
