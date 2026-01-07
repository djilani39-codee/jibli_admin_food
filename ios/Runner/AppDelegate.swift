import UIKit
import Flutter
import FirebaseCore // استيراد أساس فايربيز

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // 1. تهيئة فايربيز قبل أي شيء آخر
    FirebaseApp.configure()
    
    // 2. تسجيل إضافات فلاتر (تلقائياً)
    GeneratedPluginRegistrant.register(with: self)
    
    // 3. تعيين المفوض للإشعارات (مدمج في FlutterAppDelegate)
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
