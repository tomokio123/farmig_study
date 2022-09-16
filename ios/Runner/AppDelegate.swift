import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
            let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
            // メソッドチャンネル名
            let METHOD_CHANNEL_NAME = "mukku.com/battery"
            // FlutterMethodChannel
            let batteryChannel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: controller as! FlutterBinaryMessenger)
            // setMethodCallHandlerでコールバックを登録
            batteryChannel.setMethodCallHandler({
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                switch call.method {
                case "getBatteryLevel":
                    guard let args = call.arguments as? [String: String] else {return}
                    let name = args["name"]!
                    // swiftのばーじょんの関係でモジュールエラーになるが、
                    result("\(name) says \(self.receiveBatteryLevel())")
                default:
                    
                    result(FlutterMethodNotImplemented)
                }
            })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
