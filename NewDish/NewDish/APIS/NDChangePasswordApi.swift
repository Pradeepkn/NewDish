//
//  NDChangePasswordApi.swift
//  NewDish
//
//  Created by Pradeep on 12/1/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class NDChangePasswordApi: APIBase {

    var currentPassword : String = ""
    var newPassword : String = ""
    var confirmPassword : String = ""
    
    override func urlForRequest() -> String {
        return self.changePasswordUrl()
    }
    
    func changePasswordUrl() -> String {
        return "\(APIConfig.BaseURL)myaccount/changepassword"
    }
    
    // MARK: HTTP method type
    override func requestType() -> HTTPMethod {
        return .put
    }
    
    // MARK: API parameters
    override func requestParameter() -> [String : Any]? {
        return ["currentPassword":self.currentPassword,"newPassword": self.newPassword, "confirmPassword": self.confirmPassword]
    }
    
    override func customHTTPHeaders() -> Alamofire.HTTPHeaders? {
        let accessToken = UserDefaults.standard.object(forKey: kAccessTokenIdentifier)
        return ["access-token": accessToken as! String]
    }
    
    // MARK: Response parser
    override func parseAPIResponse(response: Dictionary<String, AnyObject>?) {
        print(response ?? -1)
        //Responce is coming as string text.
//        if response != nil {
//            let responseArray = response!["Root"] as? NSArray
//
//        }
    }
    
    // MARK: Is Multipart Request
    override func isMultipartRequest() -> Bool {
        return false
    }
    
    // MARK: MultipartData
    override func multipartData(multipartData : MultipartFormData?) {
        
    }
    override func isJSONRequest() -> Bool {
        return true
    }
}

