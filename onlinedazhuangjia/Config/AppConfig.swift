//
//  AppConfig.swift
//  BitCoinClient
//
//  Created by rightmeow on 1/22/18.
//  Copyright © 2018 rightmeow. All rights reserved.
//

import Foundation

class AppConfig: NSObject {

    // MARK: - Onboarding

    static func isOnboardingCompleted() -> Bool {
        let isOnboardingCompleted = UserDefaults.standard.bool(forKey: "isOnboardingCompleted")
        return isOnboardingCompleted
    }

    static func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "isOnboardingCompleted")
    }

    // MARK: - Elephant CRM

    /// - warning: When the key hash is nil, UserDefaults returns 0, regardless.
    static func doesCustomerIdExist() -> Bool {
        let id = AppConfig.fetchCustomerId()
        return id <= 0 ? false : true
    }

    static func fetchCustomerId() -> Int {
        return UserDefaults.standard.integer(forKey: "elephant_customer_id")
    }

    static func saveCustomerId(_ id: Int) {
        UserDefaults.standard.set(id, forKey: "elephant_customer_id")
    }

    // MAKR: - APNS

    static func doesDeviceTokenExist() -> Bool {
        if AppConfig.fetchDeviceToken() == nil {
            return false
        } else {
            return true
        }
    }

    static func fetchDeviceToken() -> String? {
        let token = UserDefaults.standard.object(forKey: "device_token") as? String
        return token
    }

    static func saveDeviceToken(deviceToken: String) {
        UserDefaults.standard.set(deviceToken, forKey: "device_token")
    }

}
