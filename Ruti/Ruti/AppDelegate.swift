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
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        KakaoSDK.initSDK(appKey: "1901929c12aad3417930d1bad00fa4db")
        LocalNotificationHelper.shared.setAuthorization()
        
        UNUserNotificationCenter.current().delegate = self
        
        // 예약 알림 설정
        let triggerDate = Calendar.current.date(byAdding: .second, value: 10, to: Date())!
        
//        LocalNotificationHelper
//            .shared
//            .pushReservedNotification(title: "루틴을 시작할 시간이에요",
//                                      body: "시작인 반인 루틴 형성, 오늘도 화이팅이에요!",
//                                      date: triggerDate,
//                                      identifier: "RESERVED_NOTI")
//        
//        LocalNotificationHelper
//            .shared
//            .pushScheduledNotification(title: "주기 알림입니다.",
//                                       body: "주기 알림 테스트 중입니다.",
//                                       hour: 2,
//                                       identifier: "SCHEDULED_NOTI")
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
    
    // Foreground(앱 켜진 상태)에서도 알림 오는 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner])
    }
    
}

