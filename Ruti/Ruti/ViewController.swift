//
//  ViewController.swift
//  Ruti
//
//  Created by leeyeon2 on 5/20/24.
//

import UIKit
//import KakaoSDKUser

class ViewController: UIViewController {
    
    @IBOutlet weak var test: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 최초 로그인 이후 자동로그인 설정
//        if UserInfo.token.count > 0 {
//            UIViewController.changeRootVCToHomeTab()
//        }
//        test.font = UIFont(name: CustomFont.h1 , size: 18.0)
//        let color = CustomColor.Category.health
    }
    
    //    @IBAction func btn(_ sender: Any) {
    //        if (UserApi.isKakaoTalkLoginAvailable()) {
    //
    //            //카톡 설치되어있으면 -> 카톡으로 로그인
    //            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
    //                if let error = error {
    //                    print(error)
    //                } else {
    //                    print("카카오 톡으로 로그인 성공")
    //
    //                    _ = oauthToken
    //                    UserApi.shared.me { [self] user, error in
    //                        if let error = error {
    //                            print(error)
    //                        } else {
    //
    //                            guard let token = oauthToken?.accessToken, let email = user?.kakaoAccount?.email,
    //                                  let name = user?.kakaoAccount?.profile?.nickname else{
    //                                      print("token/email/name is nil")
    //                                      return
    //                                  }
    //
    //                            print(email)
    //                            print(token)
    //                            print(name)
    //
    //                            //서버에 이메일/토큰/이름 보내주기
    //                        }
    //                    }
    //                }
    //            }
    //        } else {
    //
    //            // 카톡 없으면 -> 계정으로 로그인
    //            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
    //                if let error = error {
    //                    print(error)
    //                } else {
    //                    print("카카오 계정으로 로그인 성공")
    //
    //                    _ = oauthToken
    //                    // 관련 메소드 추가
    //                    UserApi.shared.me { [self] user, error in
    //                        if let error = error {
    //                            print(error)
    //                        } else {
    //
    //                            if let token = oauthToken?.accessToken {
    //                                print(token)
    //                            }
    //                            if let email = user?.kakaoAccount?.email{
    //                                print(email)
    //                            }
    //                            if let name = user?.kakaoAccount?.profile?.nickname
    //                            {
    //                                print(name)
    //                            }
    //
    //
    //
    //
    //
    //                            //서버에 이메일/토큰/이름 보내주기
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
    
}

extension UIFont {
    enum wantedFontName: String {
        case Bold = "WantedSans-Bold"
        case SemiBold = "WantedSans-SemiBold"
        case Black = "WantedSans-Black"
        case ExtraBlack = "WantedSans-ExtraBlack"
        case ExtraBold = "WantedSans-ExtraBold"
        case Medium = "WantedSans-Medium"
        case Regular = "WantedSans-Regular"
    }
    
    class func h1() -> UIFont {
        return UIFont(name: wantedFontName.Bold.rawValue, size: 28)!
    }
    
    class func h2() -> UIFont {
        return UIFont(name: wantedFontName.SemiBold.rawValue, size: 24)!
    }
    
    class func h3() -> UIFont {
        return UIFont(name: wantedFontName.Bold.rawValue, size: 20)!
    }
    
    class func h4() -> UIFont {
        return UIFont(name: wantedFontName.SemiBold.rawValue, size: 20)!
    }
    
    class func subTitle() -> UIFont {
        return UIFont(name: wantedFontName.Regular.rawValue, size: 20)!
    }
    
    class func body1() -> UIFont {
        return UIFont(name: wantedFontName.SemiBold.rawValue, size: 18)!
    }
    
    class func body2() -> UIFont {
        return UIFont(name: wantedFontName.Regular.rawValue, size: 18)!
    }
    
    class func body3() -> UIFont {
        return UIFont(name: wantedFontName.Regular.rawValue, size: 16)!
    }
    
    class func body4() -> UIFont {
        return UIFont(name: wantedFontName.SemiBold.rawValue, size: 14)!
    }
    
    class func caption1() -> UIFont {
        return UIFont(name: wantedFontName.Regular.rawValue, size: 14)!
    }
    
    class func weekly() -> UIFont {
        return UIFont(name: wantedFontName.SemiBold.rawValue, size: 18)!
    }
}
