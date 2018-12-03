//
//  NDMyProfileApi.swift
//  NewDish
//
//  Created by Pradeep on 12/1/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class NDMyProfileApi: APIBase {
    
    var profileId : String = ""
    var username : String = ""
    var email : String = ""
    var phone : String = ""
    var roleId : String = ""

    override func urlForRequest() -> String {
        return self.getProfileDetailsUrl()
    }
    
    func getProfileDetailsUrl() -> String {
        return "\(APIConfig.BaseURL)myaccount?limit=&offset="
    }
    
    // MARK: HTTP method type
    override func requestType() -> HTTPMethod {
        return .post
    }
    
    // MARK: API parameters
    override func requestParameter() -> [String : Any]? {
        return nil
    }
    
    override func customHTTPHeaders() -> Alamofire.HTTPHeaders? {
        let accessToken = UserDefaults.standard.object(forKey: kAccessTokenIdentifier)
        return ["access-token": accessToken as! String]
    }
    
    // MARK: Response parser
    override func parseAPIResponse(response: Dictionary<String, AnyObject>?) {
        print(response ?? -1)
            if response != nil {
                let responseArray = response!["Root"] as? NSArray
                for responseObject in responseArray! {
                    let dictionary : NSDictionary = responseObject as! NSDictionary
                    let profileId = (dictionary["id"] as! String)
                    let username = (dictionary["username"] as! String)
                    let email = (dictionary["email"] as! String)
                    let phone = (dictionary["phone"] as! String)
                    let roleId = (dictionary["role_id"] as! String)
                    self.profileId = profileId
                    self.username = username
                    self.email = email
                    self.phone = phone
                    self.roleId = roleId
                }
            }
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

