//
//  NDAccountDetailsApi.swift
//  NewDish
//
//  Created by Pradeep on 12/1/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class NDAccountDetailsApi: APIBase {
    
    var isUpdateAccountDetails = false
    var isGetAccountDetails = false
    
    var profileId : String = ""
    var name : String = ""
    var username : String = ""
    var email : String = ""
    var phone : String = ""
    var gender : String = ""
    var dateOfBirth : String = ""
    var roleId : String = ""
    var bio : String = ""
    
    override func urlForRequest() -> String {
        return self.myAccountDetailsUrl()
    }
    
    func myAccountDetailsUrl() -> String {
        return "\(APIConfig.BaseURL)myaccount/details"
    }
    
    // MARK: HTTP method type
    override func requestType() -> HTTPMethod {
        if (isUpdateAccountDetails) {
            return .put
        } else {
            return .get
        }
    }
    
    // MARK: API parameters
    override func requestParameter() -> [String : Any]? {
        if (isUpdateAccountDetails) {
            return ["name" : name, "username" : username, "bio": bio]
        }
        return nil
    }
    
    override func customHTTPHeaders() -> Alamofire.HTTPHeaders? {
        let accessToken = UserDefaults.standard.object(forKey: kAccessTokenIdentifier)
        return ["access-token": accessToken as! String]
    }
    
    // MARK: Response parser
    override func parseAPIResponse(response: Dictionary<String, AnyObject>?) {
        print(response ?? -1)
        if (isGetAccountDetails) {
            if response != nil {
                let responseArray = response!["Root"] as? NSArray
                for responseObject in responseArray! {
                    let dictionary : NSDictionary = responseObject as! NSDictionary
                    let profileId = (dictionary["id"] as! String)
                    let name = (dictionary["name"] as! String)
                    let username = (dictionary["username"] as! String)
                    let email = (dictionary["email"] as! String)
                    let phone = (dictionary["phone"] as! String)
                    let gender = (dictionary["gender"] as! String)
                    let dateOfBirth = (dictionary["dob"] as! String)
                    let roleId = (dictionary["role_id"] as! String)
                    self.profileId = profileId
                    self.name = name
                    self.username = username
                    self.email = email
                    self.phone = phone
                    self.gender = gender
                    self.dateOfBirth = dateOfBirth
                    self.roleId = roleId
                }
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
