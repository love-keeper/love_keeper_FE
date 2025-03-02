import UIKit
import Flutter
import NaverThirdPartyLogin // Naver SDK 임포트

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let naverThirdPartyLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Naver 로그인 URL scheme 확인 및 처리
        if url.scheme == "naverlogin" { // Info.plist에서 설정한 URL scheme과 일치
            return NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
        }
        return super.application(app, open: url, options: options)
    }
}