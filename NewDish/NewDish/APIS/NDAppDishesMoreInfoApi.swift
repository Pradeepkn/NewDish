//
//  NDAppDishesMoreInfoApi.swift
//  NewDish
//
//  Created by Kavya KN on 11/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class AppDishesMoreInfoModel: NSObject {
    var id : NSNumber = 0
    var name : String = ""
    var imageDish :  String = ""
    var eateryDataModel : EateryDataMoreInfoModel = EateryDataMoreInfoModel()
    var activities : [String] = [String]()
}

class EateryDataMoreInfoModel: NSObject {
    var id : NSNumber = 0
    var name : String = ""
    var imageMaster : String = ""
}

class NDAppDishesMoreInfoApi: APIBase {

    var appDishId : NSNumber = NSNumber()
    
    var appDishEateriesDataSource = AppDishesMoreInfoModel()
    
    override func urlForRequest() -> String {
        return self.getAppDishesMoreInfoUrl()
    }
    
    func getAppDishesMoreInfoUrl() -> String {
        return "\(APIConfig.BaseURL)app/dishes/"+"\(appDishId)"+"more_info"
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
                let dishDictionary = dictionary["dish"] as! NSDictionary

                let appDishesMoreInfoModel = AppDishesMoreInfoModel()
                
                let id = (dishDictionary["id"] as! NSNumber)
                let name = (dishDictionary["name"] as! String)
                let imageDish = (dishDictionary["img_dish"] as! String)

                appDishesMoreInfoModel.id = id
                appDishesMoreInfoModel.name = name
                appDishesMoreInfoModel.imageDish = imageDish
                
                let eateryData = dictionary["eatery"] as! NSDictionary
                let eateryDataMoreInfoModel = EateryDataMoreInfoModel()
                eateryDataMoreInfoModel.id = eateryData["id"] as! NSNumber
                eateryDataMoreInfoModel.name = eateryData["name"] as! String
                eateryDataMoreInfoModel.imageMaster = eateryData["img_master"] as! String
                
                appDishesMoreInfoModel.activities = dishDictionary["activities"] as! [String]
                
                appDishesMoreInfoModel.eateryDataModel = eateryDataMoreInfoModel
                
                self.appDishEateriesDataSource = appDishesMoreInfoModel
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
