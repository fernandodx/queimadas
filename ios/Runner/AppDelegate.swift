import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDkCwxnX7btN2E1H5x8cqAHXnHI_GtMqgs")//Casa
//    GMSServices.provideAPIKey("AIzaSyBqBgIAETahja8ZkqXMUxWUb-cPIbqIDKU") //Trabalho
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
