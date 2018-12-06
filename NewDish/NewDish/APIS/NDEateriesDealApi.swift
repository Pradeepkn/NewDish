//
//  NDEateriesDealApi.swift
//  NewDish
//
//  Created by Kavya KN on 06/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class EateriesDealModel : NSObject {
    var id : String = ""
    var title : String = ""
    var eateryDealsDescription : String = ""
    var tnc : String = ""
    var cashBackPercent : String = ""
    var cashBackAmount : NSNumber = 0
    var isActive : Bool = false
    var activeHours : String = ""
    var eateryId : NSNumber = 0
    var createdAt : String = ""
    var updatedAt : String = ""
}


class NDEateriesDealApi: APIBase {

    var eateriesDealId : NSNumber = NSNumber()
    
    var eateriesDealDataSource = EateriesDealModel()
    
    override func urlForRequest() -> String {
        return self.getEateriesDealUrl()
    }
    
    func getEateriesDealUrl() -> String {
        return "\(APIConfig.BaseURL)deals/"+"\(eateriesDealId)"
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
                
                let eateriesDealModel = EateriesDealModel()
                
                let id = (dictionary["id"] as! String)
                let title = (dictionary["title"] as! String)
                let eateryDealsDescription = (dictionary["description"] as! String)
                let tnc = (dictionary["tnc"] as! String)
                let cashBackPercent = (dictionary["cashback_percent"] as! String)
                let cashBackAmount = (dictionary["cashback_amount"] as! NSNumber)
                let isActive = (dictionary["active"] as! Bool)
                let activeHours = (dictionary["active_hours"] as! String)
                let eateryId = (dictionary["eatery_id"] as! NSNumber)
                let createdAt = (dictionary["createdAt"] as! String)
                let updatedAt = (dictionary["updatedAt"] as! String)
                
                eateriesDealModel.id = id
                eateriesDealModel.title = title
                eateriesDealModel.eateryDealsDescription = eateryDealsDescription
                eateriesDealModel.tnc = tnc
                eateriesDealModel.cashBackPercent = cashBackPercent
                eateriesDealModel.cashBackAmount = cashBackAmount
                eateriesDealModel.isActive = isActive
                eateriesDealModel.activeHours = activeHours
                eateriesDealModel.eateryId = eateryId
                eateriesDealModel.createdAt = createdAt
                eateriesDealModel.updatedAt = updatedAt
                
                self.eateriesDealDataSource = eateriesDealModel
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
