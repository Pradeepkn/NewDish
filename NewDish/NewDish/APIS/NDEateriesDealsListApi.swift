//
//  NDEateriesDealsListApi.swift
//  NewDish
//
//  Created by Kavya KN on 06/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class EateriesDealsListModel : NSObject {
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

class NDEateriesDealsListApi: APIBase {

    var eateriesDealsId : NSNumber = NSNumber()

    var eateriesDealsListDataSource = [EateriesDealsListModel]()
    
    override func urlForRequest() -> String {
        return self.getEateriesDealsListUrl()
    }
    
    func getEateriesDealsListUrl() -> String {
        return "\(APIConfig.BaseURL)eateries/"+"\(eateriesDealsId)"+"/deals"
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
                
                let eateriesDealsListModel = EateriesDealsListModel()
                
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

                eateriesDealsListModel.id = id
                eateriesDealsListModel.title = title
                eateriesDealsListModel.eateryDealsDescription = eateryDealsDescription
                eateriesDealsListModel.tnc = tnc
                eateriesDealsListModel.cashBackPercent = cashBackPercent
                eateriesDealsListModel.cashBackAmount = cashBackAmount
                eateriesDealsListModel.isActive = isActive
                eateriesDealsListModel.activeHours = activeHours
                eateriesDealsListModel.eateryId = eateryId
                eateriesDealsListModel.createdAt = createdAt
                eateriesDealsListModel.updatedAt = updatedAt
                
                self.eateriesDealsListDataSource.append(eateriesDealsListModel)
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
