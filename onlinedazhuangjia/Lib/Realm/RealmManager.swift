////
////  RealmManager.swift
////  BitCoinClient
////
////  Created by rightmeow on 1/12/18.
////  Copyright © 2018 rightmeow. All rights reserved.
////
//
//import Foundation
//import RealmSwift
//
//protocol PersistentContainerDelegate: NSObjectProtocol {
//    func persistentContainer(_ manager: RealmManager, didErr error: Error)
//    func persistentContainer(_ manager: RealmManager, didFetchCoins coins: Results<Coin>?)
//    func persistentContainer(_ manager: RealmManager, didFetchHeadlines headlines: Results<Headline>?)
//    func persistentContainer(_ manager: RealmManager, didAddObjects objects: [Object])
//    func persistentContainer(_ manager: RealmManager, didUpdateObject object: Object)
//    func didPurgeDatabase(_ manager: RealmManager)
//}
//
//extension PersistentContainerDelegate {
//    func persistentContainer(_ manager: RealmManager, didFetchCoins coins: Results<Coin>?) {}
//    func persistentContainer(_ manager: RealmManager, didFetchHeadlines headlines: Results<Headline>?) {}
//    func persistentContainer(_ manager: RealmManager, didAddObjects objects: [Object]) {}
//    func persistentContainer(_ manager: RealmManager, didUpdateObject object: Object) {}
//    func didPurgeDatabase(_ manager: RealmManager) {}
//}
//
//var realm: Realm!
//
//func setupRealm() {
//    let config = Realm.Configuration(fileURL: URL.inDocumentDirectory(fileName: "default.realm"), schemaVersion: 0, migrationBlock: nil, objectTypes: [Coin.self])
//    realm = try! Realm(configuration: config)
//}
//
//class RealmManager: NSObject {
//
//    weak var delegate: PersistentContainerDelegate?
//
//    // MARK: - Database
//
//    func purgeDatabase() {
//        do {
//            try realm.write {
//                realm.deleteAll()
//            }
//            delegate?.didPurgeDatabase(self)
//        } catch let err {
//            delegate?.persistentContainer(self, didErr: err)
//        }
//    }
//
//    // MARK: - Fetch
//
//    func fetchCoins() {
//        let coins = realm.objects(Coin.self)
//        delegate?.persistentContainer(self, didFetchCoins: coins)
//    }
//
//    func fetchHeadlines() {
//        let headlines = realm.objects(Headline.self)
//        delegate?.persistentContainer(self, didFetchHeadlines: headlines)
//    }
//
//    // MARK: - Add
//
//    func addObjects(objects: [Object]) {
//        do {
//            try realm.write {
//                realm.add(objects, update: true)
//            }
//            delegate?.persistentContainer(self, didAddObjects: objects)
//        } catch let err {
//            delegate?.persistentContainer(self, didErr: err)
//        }
//    }
//
//    // MARK: - Update
//
//    func updateObject(object: Object, keyedValues: [String : Any]) {
//        do {
//            try realm.write {
//                object.setValuesForKeys(keyedValues)
//                realm.add(object, update: true)
//            }
//            delegate?.persistentContainer(self, didUpdateObject: object)
//        } catch let err {
//            delegate?.persistentContainer(self, didErr: err)
//        }
//    }
//
//}

