import Foundation
import Capacitor
import WidgetKit

@objc(WidgetBridgePlugin)
public class WidgetBridgePlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "WidgetBridgePlugin"
    public let jsName = "WidgetBridge"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "setDeck", returnType: CAPPluginReturnPromise)
    ]

    @objc func setDeck(_ call: CAPPluginCall) {
        let json = call.getString("json") ?? "[]"
        if let d = UserDefaults(suiteName: "group.tr.rahimov.lexirace") {
            d.set(json, forKey: "deck")
        }
        WidgetCenter.shared.reloadAllTimelines()
        call.resolve()
    }
}
