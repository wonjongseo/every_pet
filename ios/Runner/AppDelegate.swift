import UIKit
import Flutter
import ContactsUI

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let channelName = "com.wonjongseo.every_pets/channel"
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    print("Navite Called IOS")

      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let phoneChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)
   

      phoneChannel.setMethodCallHandler {
            (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "callPhone" {
              if let args = call.arguments as? [String: Any],
                 let phoneNumber = args["number"] as? String {
                self.makePhoneCall(phoneNumber)
                result(true)
              } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments", details: nil))
              }
            } else {
              result(FlutterMethodNotImplemented)
            }
          }
    
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    private func makePhoneCall(_ phoneNumber: String) {
      if let phoneUrl = URL(string: "tel://\(phoneNumber)"),
         UIApplication.shared.canOpenURL(phoneUrl) {
        UIApplication.shared.open(phoneUrl)
      }
    }
}
