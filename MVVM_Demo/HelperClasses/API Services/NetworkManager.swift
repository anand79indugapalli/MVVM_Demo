//
//  NetworkManager.swift
//  SnackDrop
//
//  Created by Uday on 10/30/17.
//  Copyright © 2017 Uday. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Reachability

/// NetworkManager
class NetworkManager: NSObject {
    /// boolean for Network Condition
    var isReachable: Bool = false
    /// variable for network rechability
    fileprivate var reachability: Reachability?

    /// shared class for network rechability
    class var shared: NetworkManager {
        struct Static {
            static var instance: NetworkManager?
            static var token: Int = 0
        }
        if Static.instance == nil {
            Static.instance = NetworkManager()
        }
        return Static.instance!
    }
    
    /// initializer
    override init() {
        super.init()
        reachability = Reachability.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            try reachability!.startNotifier()
        } catch {
        }
    }

    /// requestForData
    ///
    /// - Parameters:
    ///   - url: url
    ///   - param: parameters
    ///   - httpMethod: httpMethod
    ///   - headerParam: headerParameters
    ///   - encodingType: encodingType
    ///   - success: success Response
    ///   - failure: failure Response
    func requestForData(url: String, param: [String: Any]?, httpMethod: HTTPMethod, headerParam: HTTPHeaders?, encodingType: ParameterEncoding = URLEncoding.default, success: @escaping (_ response: Data) -> Void, failure: @escaping (_ response: [String: Any]) -> Void) {
            hideNoInternetScreen()
            Alamofire.request(url, method: httpMethod, parameters: param, encoding: encodingType, headers: headerParam).responseData(completionHandler: { (response) in
                debugPrint(response)
                switch response.result {
                case .success:
                    if let responseData = response.result.value {
                        success(responseData)
                    } else {
                        failure(["status": false, "message": AlertActionText.someThingWentWrong])
                    }
                case .failure:
                    if let responseData = response.result.error {
                        failure(["status": false, "message": responseData.localizedDescription])
                    } else {
                        failure(["status": false, "message": AlertActionText.someThingWentWrong])
                    }
                }
            })
    }
    
    /// requestFor
    ///
    /// - Parameters:
    ///   - url: url
    ///   - param: parameters
    ///   - httpMethod: httpMethod
    ///   - includeHeader: headerParameters
    ///   - encodingType: encodingType
    ///   - success: success Response
    ///   - failure: failure Response
    func requestFor(url: String, param: [String: Any]?, httpMethod: HTTPMethod, includeHeader: Bool, encodingType: ParameterEncoding = URLEncoding.default, success: @escaping (_ response: [String: Any]) -> Void, failure: @escaping (_ response: [String: Any]) -> Void) {
//        if includeHeader {
//            headerParam = getHeaderParam()
//        }
        requestFor(url: url, param: param, httpMethod: httpMethod, headerParam: nil, encodingType: encodingType, success: success, failure: failure)
    }
    
    /// requestFor
    ///
    /// - Parameters:
    ///   - url: url
    ///   - param: parameters
    ///   - httpMethod: httpMethod
    ///   - headerParam: headerParameters
    ///   - encodingType: encodingType
    ///   - success: success Response
    ///   - failure: failure Response
    func requestFor(url: String, param: [String: Any]?, httpMethod: HTTPMethod, headerParam: HTTPHeaders?, encodingType: ParameterEncoding = URLEncoding.default, success:@escaping (_ response: [String: Any]) -> Void, failure:@escaping (_ response: [String: Any]) -> Void) {
            hideNoInternetScreen()
            Alamofire.request(url, method: httpMethod, parameters: param, encoding: encodingType, headers: headerParam).responseJSON { response in
                print(param ?? "param empty")
                debugPrint(response)
                if let headers = response.response?.allHeaderFields as? [String: String] {
                    if let header = headers["x-access-token"] {
                        print(header)
                        //This value will saved in user defaults
                        //AppPref.shared.accessToken = header
                    }
                }
                switch response.result {
                case .success:
                    if let responseDict = response.result.value as? [String: Any] {
                        if let status = responseDict["status"] as? String, status == "ok" {
                            success(responseDict)
                        } else {
                            let message = responseDict["error"] as? String ?? AlertActionText.someThingWentWrong
                            failure(["status": false, "message": message])
                        }
                    } else {
                        failure(["status": false, "message": AlertActionText.someThingWentWrong])
                    }
                case .failure:
                    failure(["status": false, "message": response.result.error?.localizedDescription ?? AlertActionText.someThingWentWrong])
                }
            }
    }
    
    // MARK: Rechability
    /// reachabilityChanged
    ///
    /// - Parameter notification: notification
    @objc func reachabilityChanged(_ notification: Notification) {
        if let reachability = notification.object as? Reachability {
            switch reachability.connection {
            case .wifi:
                isReachable = true
                print("Reachable via WiFi")
            case .cellular:
                isReachable = true
                print("Reachable via Cellular")
            case .none:
                isReachable = false
                print("Network not reachable")
            }
        } else { isReachable = false }
    }
    
//    // MARK: - API Header
//    /// getHeaderParam
//    ///
//    /// - Returns: HTTPHeaders
//    func getHeaderParam() -> HTTPHeaders {
//        let headerParam: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded", "x-access-token": AppPref.shared.accessToken ?? ""]
//        return headerParam
//    }
    
    // MARK: - Internet Connection Error.
    /// showNoInternetScreen
    func showNoInternetScreen() {
        if let vcToPresent = Constants.navigationController.viewControllers.last {
            vcToPresent.view.endEditing(true)
            vcToPresent.showAlert(title: "", message: AlertActionText.someThingWentWrong, buttonTitle: ActionButtonText.ok)
        }
    }
    
    /// hideNoInternetScreen
    func hideNoInternetScreen() {
        if NetworkManager.shared.isReachable {
        }
    }
}
