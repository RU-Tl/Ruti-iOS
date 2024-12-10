//
//  AppDelegate.swift
//  Ruti
//
//  Created by leeyeon2 on 5/20/24.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tmpDirURL = FileManager.default.temporaryDirectory
        let LibDirURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
        let DocDirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let BundleURL = Bundle.main.bundleURL
        print(tmpDirURL)
        print(LibDirURL!)
        print(BundleURL)
        // Override point for customization after application launch.
        KakaoSDK.initSDK(appKey: "1901929c12aad3417930d1bad00fa4db")
        // 알림 설정을 위한 권한 요청
        LocalNotificationHelper.shared.setAuthorization()
        // local notification delegate 채택
        UNUserNotificationCenter.current().delegate = self
        if #available(iOS 15.0, *) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        //바꾸고 싶은 색으로 backgroundColor를 설정
        UITabBar.appearance().backgroundColor = UIColor.init(hexCode: CustomColor.black)
        }
        let content = UNMutableNotificationContent()
        content.title = "Weekly Staff Meeting"
        content.body = "Every Tuesday at 2pm"
        var dateComponents = DateComponents()
        
        // weekday: 월1 화2 수3 목4 금5 토6
        
        
        dateComponents.calendar = Calendar.current
        dateComponents.weekday = 7
        dateComponents.hour = 17
        dateComponents.minute = 55
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: true)
        
        let request = UNNotificationRequest(identifier: "test",
                    content: content, trigger: trigger)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }

//        
//        LocalNotificationHelper
//            .shared
//            .pushReservedNotification(title: "wnrks 시작할 시간이에요",
//                                      body: "시작인 반인 루틴 형성, 오늘도 화이팅이에요!",
////                                      trigger: triggerDate,
//                                      identifier: "RESERVED_NOTI")
        

        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    

    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            
            // 해당 Notification의 content로 메시지 별 분기 가능
            
//            if response.notification.request.content.title == "해당 컨텐츠의 타이틀 입력" {
            
                // 5개의 탭을 가지고 있는 TabBarController 중 4번째 뷰(Index = 3)을 띄우기 위해 노티를 보냄
                NotificationCenter.default.post(name: Notification.Name("noti"), object: nil, userInfo: ["index":3])
//            }
    }
    
    // Foreground(앱 켜진 상태)에서도 알림 오는 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner])
    }
}
