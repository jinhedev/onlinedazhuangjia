//
//  WebServiceManager.swift
//  BitCoinClient
//
//  Created by rightmeow on 1/10/18.
//  Copyright © 2018 rightmeow. All rights reserved.
//

import Foundation
import Alamofire

protocol WebServiceManagerDelegate: NSObjectProtocol {
    func webService(_ manager: WebServiceManager, didErr error: Error, type: WebServiceType)
    func webService(_ manager: WebServiceManager, didFetch data: Any, type: WebServiceType)
    func webService(_ manager: WebServiceManager, didPost data: Any, type: WebServiceType)
    func webService(_ manager: WebServiceManager, didPatch data: Any, type: WebServiceType)
    func webService(_ manager: WebServiceManager, didDelete data: Any, type: WebServiceType)
}

extension WebServiceManagerDelegate {
    func webService(_ manager: WebServiceManager, didFetch data: Any, type: WebServiceType) {}
    func webService(_ manager: WebServiceManager, didPost data: Any, type: WebServiceType) {}
    func webService(_ manager: WebServiceManager, didPatch data: Any, type: WebServiceType) {}
    func webService(_ manager: WebServiceManager, didDelete data: Any, type: WebServiceType) {}
}

/**
 WebServiceType is a user-define enum that specified what type of data response the user expect to get.
 - warning: Expected response may or may not be the actual response. Be warned!
 */
enum WebServiceType {
    case charts
    case tickers
    case add_customer
    case headlines
    case tests
}

class WebServiceManager: NSObject {

    // MARK: - Delegates

    weak var delegate: WebServiceManagerDelegate?

    // MARK: - Implementations

    func fetch(fromUrl: String, parameters: [String : String]? = nil, headers: [String : String]? = nil, type: WebServiceType) {
        Alamofire.request(fromUrl, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                self.delegate?.webService(self, didFetch: value, type: type)
            case .failure(let error):
                self.delegate?.webService(self, didErr: error, type: type)
            }
        }
    }

    func post(fromUrl: String, parameters: [String : Any]? = nil, headers: [String : String]? = nil, type: WebServiceType) {
        Alamofire.request(fromUrl, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                self.delegate?.webService(self, didPost: value, type: type)
            case .failure(let error):
                self.delegate?.webService(self, didErr: error, type: type)
            }
        }
    }

    func patch() {
        // TODO: implement this if needed
    }

    func delete() {
        // TODO: implement this if needed
    }

}
