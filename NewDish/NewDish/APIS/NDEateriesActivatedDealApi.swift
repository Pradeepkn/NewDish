//
//  NDEateriesActivatedDealApi.swift
//  NewDish
//
//  Created by Kavya KN on 07/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class EateriesActivatedDealModel : NSObject {
    var message : String = ""
    var dataModel : DealDataModel = DealDataModel()
}

class DealDataModel : NSObject {
    var id : NSNumber = 0
    var dealId : NSNumber = 0
    var accountId : NSNumber = 0
    var eateryId : NSNumber = 0
    var status : Bool = false
    var billAmount : String = ""
    var dealStartAt : String = ""
    var dealEndAt : String = ""
    var createdAt : String = ""
    var updatedAt : String = ""
}

class NDEateriesActivatedDealApi: APIBase {
    
    var eateriesDealId : NSNumber = NSNumber()

    var eateriesActivatedDealDataSource = [EateriesActivatedDealModel]()
    
    override func urlForRequest() -> String {
        return self.getEateriesActivatedDealUrl()
    }
    
    func getEateriesActivatedDealUrl() -> String {
        return "\(APIConfig.BaseURL)deals/"+"\(eateriesDealId)"+"/activate"
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
                
                let eateriesActivatedDealModel = EateriesActivatedDealModel()
                let message = (dictionary["msg"] as! String)
                eateriesActivatedDealModel.message = message
                
                let data = dictionary["data"] as! NSDictionary
                
                let dealDataModel = DealDataModel()
                
                dealDataModel.id = data["id"] as! NSNumber
                dealDataModel.dealId = data["deal_id"] as! NSNumber
                dealDataModel.accountId = data["account_id"] as! NSNumber
                dealDataModel.eateryId = data["eatery_id"] as! NSNumber
                dealDataModel.status = data["status"] as! Bool
                dealDataModel.billAmount = data["bill_amount"] as! String
                dealDataModel.dealStartAt = data["deal_start_at"] as! String
                dealDataModel.dealEndAt = data["deal_end_at"] as! String
                dealDataModel.createdAt = data["createdAt"] as! String
                dealDataModel.updatedAt = data["updatedAt"] as! String

                eateriesActivatedDealModel.dataModel = dealDataModel
                self.eateriesActivatedDealDataSource.append(eateriesActivatedDealModel)
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
