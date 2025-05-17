import Flutter
import UIKit
import NaverThirdPartyLogin

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    print("Received URL: \(url.absoluteString)") // 디버깅 로그 추가
    let result = naverLoginInstance?.application(app, open: url, options: options) ?? false
    print("Naver URL handling result: \(result)") // 처리 결과 로그
    return result || super.application(app, open: url, options: options)
  }
}
