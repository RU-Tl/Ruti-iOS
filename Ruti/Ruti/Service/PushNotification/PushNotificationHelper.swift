//
//  PushNotificationHelper.swift
//  Ruti
//
//  Created by leeyeon2 on 5/24/24.
//

import Foundation
import UserNotifications
import UIKit

/// 로컬 Push Notification에 대한 인증 및 실행 클래스입니다.
///
/// - Note: 싱글턴으로 구현되어 있습니다. `LocalNotificationHelper.shared`를 통해 접근해주세요.
class LocalNotificationHelper {
    static let shared = LocalNotificationHelper()
    
    private init() {}
    
    ///Push Notification에 대한 인증 설정 함수입니다.
    func setAuthorization() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
    }
    
    /// 호출 시점을 기점 seconds초 이후에 Notification을 보냅니다.
    ///
    /// - Parameters:
    ///   - title: Push Notification에 표시할 제목입니다.
    ///   - body: Push Notification에 표시할 본문입니다.
    ///   - seconds: 현재로부터 seconds초 이후에 알림을 보냅니다. 0보다 커야하며 1이하 실수도 가능합니다.
    ///   - identifier: 실행 취소, 알림 구분 등에 사용되는 식별자입니다. "TEST_NOTI" 형식으로 작성해주세요.
    func pushNotification(title: String, body: String, seconds: Double, identifier: String) {
        
        assert(seconds > 0, "seconds는 0보다 커야합니다. (런타임 에러)")
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier,
                                            content: notificationContent,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    // Calendar trigger
    func pushReservedNotification(title: String, body: String, identifier: String) {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        
        // ✅
//        let triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
        var dateComponents = DateComponents()
        // weekday: 월1 화2 수3 목4 금5 토6 일7
        dateComponents.calendar = Calendar.current
        dateComponents.weekday = 6
        dateComponents.hour = 17
        dateComponents.minute = 37
        let triggerDate = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier,
                                            content: notificationContent,
                                            trigger: triggerDate)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    func pushScheduledNotification(title: String, body: String, hour: Int, identifier: String) {

        assert(hour >= 0 || hour <= 24, "시간은 0이상 24이하로 입력해주세요.")

        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body

        var dateComponents = DateComponents()
        dateComponents.hour = hour  // ✅ 알림을 보낼 시간 (24시간 형식)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true) // ✅ true
        let request = UNNotificationRequest(identifier: identifier,
                                            content: notificationContent,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    func printPendingNotification() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests {
                print("Identifier: \(request.identifier)")
                print("Title: \(request.content.title)")
                print("Body: \(request.content.body)")
                print("Trigger: \(String(describing: request.trigger))")
                print("---")
            }
        }
    }
}
