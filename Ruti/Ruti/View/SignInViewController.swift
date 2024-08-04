//
//  SignInViewController.swift
//  Ruti
//
//  Created by leeyeon2 on 5/23/24.
//

import UIKit
import AuthenticationServices
import KakaoSDKUser
import Alamofire

class SignInViewController: UIViewController, StoryboardInitializable {
    
    static var storyboardID: String = "SignIn"
    static var storyboardName: String = "Main"
    
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 최초 로그인 이후 자동로그인 설정
        if UserInfo.token.count > 0 {
            UIViewController.changeRootVCToHomeTab()
        }else{
            initUI()
        }
    }
    
    @IBAction func kakaoSignIn(_ sender: Any) {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                // oauthToken?.accessToken
                if error != nil {
                    //                    AlertView.showAlert(title: Global.kakaoSignInErrorTitle,
                    //                                        message: Global.kakaoSignInErrorMessage,
                    //                                        viewController: self,
                    //                                        dismissAction: nil)
                }
                else {
                    self.setKakaoUserInfo()
                }
            }
        }else{
            // 카카오톡 미설치인 경우 - 카카오톡 계정 로그인 웹화면으로 이동
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if error != nil {
                    //                    AlertView.showAlert(title: Global.kakaoSignInErrorTitle,
                    //                                        message: Global.kakaoSignInErrorMessage,
                    //                                        viewController: self,
                    //                                        dismissAction: nil)
                }
                else {
                    _ = oauthToken
                    self.setKakaoUserInfo()
                }
            }
        }
    }
    
    func setKakaoUserInfo() {
        // 카카오 계정 정보 가져오기
        UserApi.shared.me {(user, error) in
            if let error = error {
                print(error)
            } else {
                let parameter: Parameters = [
                    "name" : user?.kakaoAccount?.profile?.nickname ?? "no email",
                    "email": user?.kakaoAccount?.email ?? "no email"
                ]
                let request = APIRequest(method: .post,
                                         path: "/member/login",
                                         param: parameter,
                                         headers: APIConfig.headers)
                
                APIService.shared.perform(request: request,
                                          completion: { [self] (result) in
                    switch result {
                    case .success(let data):
                        if let memberId = data.body["memberId"] as? Int, let token = data.body["token"] as? String {
                            UserDefaults.standard.set("\(String(describing: parameter["name"]!))", forKey: "name")
                            UserDefaults.standard.set("\(String(describing: parameter["email"]!))", forKey: "email")
                            UserDefaults.standard.set("\(memberId)", forKey: "memberId")
                            UserDefaults.standard.set("\(token)", forKey: "token")
                            UIViewController.changeRootVCToHomeTab()
                        }
                    case .failure:
                        print(APIError.networkFailed)
                    }
                })
            }
        }
    }
    
    func initUI() {
        text1.font = UIFont.h3()
        text2.font = UIFont.body2()
        let image = UIImage(named: "logo_kakao")?.imageWith(newSize: .init(width: 30, height: 30))
        signInBtn.setImage(image, for: .normal)
        signInBtn.configuration?.imagePadding = 20
    }
}
