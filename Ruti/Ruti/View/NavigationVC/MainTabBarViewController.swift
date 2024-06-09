//
//  MainTabBarViewController.swift
//  Ruti
//
//  Created by leeyeon2 on 6/9/24.
//

import UIKit

class MainTabBarViewController: UITabBarController, StoryboardInitializable {
    static var storyboardName: String = "Main"
    static var storyboardID: String = "MainPage"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension UIViewController {
    // 탭화면으로 이동
    static func changeRootVCToHomeTab() {
        let vc = MainTabBarViewController.instantiate()
        
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            windowScene.windows.first?.rootViewController = vc
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }
    
    //로그인 화면으로 이동
    static func changeRootVCToSignIn() {
        let vc = SignInViewController.instantiate()

        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            windowScene.windows.first?.rootViewController = vc
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }
}
