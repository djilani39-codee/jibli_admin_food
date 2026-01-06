import UIKit
import Flutter
import Firebase
import UserNotifications

@main // تم التحديث هنا لتجنب خطأ التبعية
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // 1. إعداد Firebase
    FirebaseApp.configure()
    
    // 2. إعداد مفوض الإشعارات (Delegate) وطلب الصلاحيات
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        if let error = error {
          print("UNUserNotificationCenter requestAuthorization error: \(error)")
        }
        DispatchQueue.main.async {
          application.registerForRemoteNotifications()
        }
      }
    } else {
      let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
      application.registerForRemoteNotifications()
    }

    // 3. تعيين مفوض Messaging للحصول على توكن FCM
    Messaging.messaging().delegate = self
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // 4. معالجة توكن APNs وتمريره لـ Firebase
  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken
    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }

  // استقبال توكن FCM
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("Firebase registration token: \(String(describing: fcmToken))")
  }
}
