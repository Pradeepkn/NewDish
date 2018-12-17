//
//  NDEateriesSearchApi.swift
//  NewDish
//
//  Created by Kavya KN on 17/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class EateriesListSearchModel: NSObject {
    var type : String = ""
    var data : EateriesDataSearchModel = EateriesDataSearchModel()
}

class EateriesDataSearchModel: NSObject {
    var id : NSNumber = 0
    var name : String = ""
    var imageMaster : String = ""
    var localityId : NSNumber = 0
    var costForTwo : NSNumber = 0
    var localityName : String = ""
}

class NDEateriesSearchApi: APIBase {

    var eateriesListDataSource = [EateriesListSearchModel]()
    
    override func urlForRequest() -> String {
        return self.changePasswordUrl()
    }
    
    func changePasswordUrl() -> String {
        return "\(APIConfig.BaseURL)app/search/eatery"
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
                
                let eateriesListModel = EateriesListSearchModel()
                
                let type = (dictionary["type"] as! String)
                eateriesListModel.type = type
                
                let dataDictionary = dictionary["data"] as! NSDictionary
                let dataModel : EateriesDataSearchModel = EateriesDataSearchModel()
                
                dataModel.id = dataDictionary["id"] as! NSNumber
                dataModel.name = dataDictionary["name"] as! String
                dataModel.imageMaster = dataDictionary["img_master"] as! String
                dataModel.localityId = dataDictionary["locality_id"] as! NSNumber
                dataModel.costForTwo = dataDictionary["cost_for_two"] as! NSNumber
                dataModel.localityName = dataDictionary["locality.name"] as! String
                
                eateriesListModel.data = dataModel
                
                self.eateriesListDataSource.append(eateriesListModel)
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
