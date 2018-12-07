//
//  NDEateriesDishesListApi.swift
//  NewDish
//
//  Created by Kavya KN on 07/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class EateriesDishesModel: NSObject {
    var id : NSNumber = 0
    var name : String = ""
    var imageMaster : String = ""
    var dishes : [DishesListModel] = [DishesListModel]()
    var locality : LocalityModel = LocalityModel()
    var city : DishCityModel = DishCityModel()
}

class DishesListModel: NSObject {
    var id : NSNumber = 0
    var name : String = ""
    var imageDish : String = ""
    var price : NSNumber = 0
}

class LocalityModel: NSObject {
    var name : String = ""
}

class DishCityModel: NSObject {
    var name : String = ""
}

class NDEateriesDishesListApi: APIBase {
    
    var eateriesDishId : NSNumber = NSNumber()

    var eateriesDishesDataSource = EateriesDishesModel()
    
    override func urlForRequest() -> String {
        return self.getEateriesDishesListUrl()
    }
    
    func getEateriesDishesListUrl() -> String {
        return "\(APIConfig.BaseURL)eateries/"+"\(eateriesDishId)"+"/dishes"
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
                
                let eateriesDishesModel = EateriesDishesModel()
            
                let id = (dictionary["id"] as! NSNumber)
                let name = (dictionary["name"] as! String)
                let imageMaster = (dictionary["img_master"] as! String)
                
                eateriesDishesModel.id = id
                eateriesDishesModel.name = name
                eateriesDishesModel.imageMaster = imageMaster
                
                let dishesArray = dictionary["dishes"] as? NSMutableArray
                
                for dish in dishesArray ?? [] {
                    let dishDictionary : NSDictionary = dish as! NSDictionary
                    
                    let dishesListModel = DishesListModel()
                    
                    let id = (dishDictionary["id"] as! NSNumber)
                    let name = (dishDictionary["name"] as! String)
                    let imageDish = (dishDictionary["img_dish"] as! String)
                    let price = (dishDictionary["price"] as! NSNumber)
                    
                    dishesListModel.id = id
                    dishesListModel.name = name
                    dishesListModel.imageDish = imageDish
                    dishesListModel.price = price
                    
                    eateriesDishesModel.dishes.append(dishesListModel)
                }
                
                let localityData = dictionary["locality"] as! NSDictionary
                let localityModel = LocalityModel()
                localityModel.name = localityData["name"] as! String
                
                eateriesDishesModel.locality = localityModel
                
                let cityData = dictionary["locality"] as! NSDictionary
                let cityModel = DishCityModel()
                cityModel.name = cityData["name"] as! String
                
                eateriesDishesModel.city = cityModel
                
                self.eateriesDishesDataSource = eateriesDishesModel
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
