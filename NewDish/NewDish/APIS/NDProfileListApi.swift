//
//  NDProfileListApi.swift
//  NewDish
//
//  Created by Pradeep on 12/1/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class ProfileListModel : NSObject {
    var profileId : String = ""
    var name : String = ""
    var username : String = ""
    var picture : String = ""
}

class NDProfileListApi: APIBase {

    var profileListDataSource = [ProfileListModel]()
    
    override func urlForRequest() -> String {
        return self.changePasswordUrl()
    }
    
    func changePasswordUrl() -> String {
        return "\(APIConfig.BaseURL)app/search/profile"
    }
    
    // MARK: HTTP method type
    override func requestType() -> HTTPMethod {
        return .get
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
                let profileListModel = ProfileListModel()
                let profileId = (dictionary["id"] as! String)
                let name = (dictionary["name"] as! String)
                let username = (dictionary["username"] as! String)
                profileListModel.profileId = profileId
                profileListModel.name = name
                profileListModel.username = username
                self.profileListDataSource.append(profileListModel)
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
