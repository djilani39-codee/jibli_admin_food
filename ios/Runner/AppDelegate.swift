import UIKit
import Flutter
import FirebaseCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // 1. تهيئة Firebase
    FirebaseApp.configure()
    
    // 2. تسجيل الإضافات
    GeneratedPluginRegistrant.register(with: self)
    
    // 3. ضبط مفوض الإشعارات (FlutterAppDelegate يتولى ذلك عادةً)
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
import UIKit
import Flutter
import FirebaseCore // استيراد أساس فايربيز
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, UNUserNotificationCenterDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // 1. تهيئة فايربيز قبل أي شيء آخر
    FirebaseApp.configure()
    
    // 2. تسجيل إضافات فلاتر (تلقائياً)
    GeneratedPluginRegistrant.register(with: self)
    
    // 3. تعيين المفوض للإشعارات
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    // 4. تسجيل للإشعارات عن بعد
    application.registerForRemoteNotifications()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound, .badge])
  }
}
