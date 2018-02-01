//
//  AppDelegate.swift
//  在线百家乐-威尼斯人娱乐场
//
//  Created by Changcui Wan on 2017/12/12.
//  Copyright © 2017年 Changcui Wan. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
//    var realmManager: RealmManager?
    var appDataSocketConnector: AppDataSocketConnector?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.mainSetup(with: application)
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    func applicationWillTerminate(_ application: UIApplication) {
    }
}

