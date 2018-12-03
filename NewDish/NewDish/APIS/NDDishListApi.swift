//
//  NDDishListApi.swift
//  NewDish
//
//  Created by Pradeep on 12/1/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class DishListModel : NSObject {
    var id : String = ""
    var name : String = ""
    var eateryId : String = ""
    var price : String = ""
    var imageDish : String = ""
    var eateryModel : EateryModel = EateryModel()
}

class EateryModel : NSObject {
    var name : String = ""
    var imageMaster : String = ""
    var cityModel : CityModel = CityModel()
}

class CityModel : NSObject {
    var id : String = ""
    var name : String = ""
}

class NDDishListApi: APIBase {

    var dishListDataSource = [DishListModel]()
    
    override func urlForRequest() -> String {
        return self.changePasswordUrl()
    }
    
    func changePasswordUrl() -> String {
        return "\(APIConfig.BaseURL)search/dish?q="
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
                
                let dishListModel = DishListModel()
                let id = (dictionary["id"] as! String)
                let name = (dictionary["name"] as! String)
                let eateryId = (dictionary["eatery_id"] as! String)
                let price = (dictionary["price"] as! String)
                
                dishListModel.id = id
                dishListModel.name = name
                dishListModel.eateryId = eateryId
                dishListModel.price = price
                
                let eateryData = dictionary["eatery"] as! NSDictionary
                let eateryModel = EateryModel()
                eateryModel.name = eateryData["name"] as! String
                eateryModel.imageMaster = eateryData["img_master"] as! String
                
                let cityData = eateryData["city"] as! NSDictionary
                let cityModel = CityModel()
                cityModel.id = cityData["id"] as! String
                cityModel.name = cityData["name"] as! String
                
                eateryModel.cityModel = cityModel
                dishListModel.eateryModel = eateryModel
                self.dishListDataSource.append(dishListModel)
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
