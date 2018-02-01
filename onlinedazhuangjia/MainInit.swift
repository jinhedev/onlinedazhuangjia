//
//  MainInit.swift
//  BitCoinClient
//
//  Created by rightmeow on 1/22/18.
//  Copyright © 2018 rightmeow. All rights reserved.
//

import UIKit
import UserNotifications

extension AppDelegate: AppDataSocketDelegate, UNUserNotificationCenterDelegate {

    func mainSetup(with application: UIApplication) {
//        setupRealm()
        self.setupRemoteNotification(with: application)
        self.setupAppDataSocketDelegate()
    }

    // MARK: - Remote notifications

    func setupRemoteNotification(with application: UIApplication) {
        if !AppConfig.doesDeviceTokenExist() {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert, .badge, .sound]) { (completed: Bool, error: Error?) in
                if let err = error {
                    print(err.localizedDescription)
                } else {
                    if completed == true {
                        DispatchQueue.main.async {
                            application.registerForRemoteNotifications()
                        }
                    }
                }
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("User Info: ", notification.request.content.userInfo)
        completionHandler([.alert, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
        print("User Info: ", response.notification.request.content.userInfo)
        completionHandler()
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // persist token into UserDefaults
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        AppConfig.saveDeviceToken(deviceToken: token)
        // request(post) a new customer_id to the elephant CRM
        let payload: Dictionary<String, String> = ["app_id" : "5", "instance_id" : "23", "push_token" : token, "type_id" : "1"]
        appDataSocketConnector?.sendNormalRequest(withPack: payload, andServiceCode: "add_customer", andCustomerTag: 0)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }

    // MARK: - AppDataSocketDelegate

    private func setupAppDataSocketDelegate() {
        self.appDataSocketConnector = AppDataSocketConnector(delegate: self)
    }

    func datasocketDidReceiveNormalResponse(withDict resultDic: [AnyHashable : Any]!, andCustomerTag c_tag: Int) {
        print(resultDic)
        if let responseDict = resultDic["payload"] as? Dictionary<String, Int> {
            if !AppConfig.doesCustomerIdExist() {
                AppConfig.saveCustomerId(responseDict["customer_id"]!)
            }
        }
    }

    func dataSocketDidGetResponse(withTag tag: Int, andCustomerTag c_tag: Int) {
        // TODO: implement this
    }

    func dataSocketWillStartRequest(withTag tag: Int, andCustomerTag c_tag: Int) {
        // TODO: implement this
    }

    func dataSocketError(withTag tag: Int, andMessage message: String!, andCustomerTag c_tag: Int) {
        print(message)
    }

}
