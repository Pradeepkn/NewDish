//
//  NDHomeListEateriesApi.swift
//  NewDish
//
//  Created by Kavya KN on 05/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class HomeListEateriesModel : NSObject {
    var likesCount : NSNumber = 0
    var commentsCount : NSNumber = 0
    var id : NSNumber = 0
    var type : String = ""
    var userId : NSNumber = 0
    var eateryId : NSNumber = 0
    var dishId : NSNumber = 0
    var rate : NSNumber = 0
    var mediaType : String = ""
    var mediaUrl : String = ""
    var showInTimeline : Bool = false
    var eateryDescription : String = ""
    var createdAt : String = ""
    var eateryName : String = ""
    var eateryImageMaster : String = ""
    var dishName : String = ""
    var userName : String = ""
    var userPicture : String = ""
    var isLiked : Bool = false
}

class NDHomeListEateriesApi: APIBase {

    var homeListEateriesModel = [HomeListEateriesModel]()
    var eateriesListDataSource = [[HomeListEateriesModel]]()
    
    override func urlForRequest() -> String {
        return self.getHomeListEateriesUrl()
    }
    
    func getHomeListEateriesUrl() -> String {
        return "\(APIConfig.BaseURL)home?limit=30&offset=0"
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
            for responseObjects in responseArray! {
                let eateryListArray : NSArray = responseObjects as? NSArray ?? []
                for responseObject in eateryListArray{
                    let dictionary : NSDictionary = responseObject as! NSDictionary
                    
                    let eateriesListModel = HomeListEateriesModel()
   
                    let likesCount = (dictionary["likes_count"] as! NSNumber)
                    let commentsCount = (dictionary["comments_count"] as! NSNumber)
                    let id = (dictionary["id"] as! NSNumber)
                    let type = (dictionary["type"] as! String)
                    let userId = (dictionary["user_id"] as! NSNumber)
                    let eateryId = (dictionary["eatery_id"] as! NSNumber)
                    let dishId = (dictionary["dish_id"] as! NSNumber)
                    let rate = (dictionary["rate"] as! NSNumber)
                    let mediaType = (dictionary["media_type"] as! String)
                    let mediaUrl = (dictionary["media_url"] as! String)
                    let showInTimeline = (dictionary["show_in_timeline"] as! Bool)
                    let eateryDescription = (dictionary["description"] as! String)
                    let createdAt = (dictionary["createdAt"] as! String)
                    let eateryName = (dictionary["eatery_name"] as! String)
                    let eateryImageMaster = (dictionary["eatery_img_master"] as! String)
                    let dishName = (dictionary["dish_name"] as! String)
                    let userName = (dictionary["user_name"] as! String)
                    let userPicture = (dictionary["user_picture"] as! String)
                    let isLiked = (dictionary["is_liked"] as! Bool)

                    eateriesListModel.likesCount = likesCount
                    eateriesListModel.commentsCount = commentsCount
                    eateriesListModel.id = id
                    eateriesListModel.type = type
                    eateriesListModel.userId = userId
                    eateriesListModel.eateryId = eateryId
                    eateriesListModel.dishId = dishId
                    eateriesListModel.rate = rate
                    eateriesListModel.mediaType = mediaType
                    eateriesListModel.mediaUrl = mediaUrl
                    eateriesListModel.showInTimeline = showInTimeline
                    eateriesListModel.eateryDescription = eateryDescription
                    eateriesListModel.createdAt = createdAt
                    eateriesListModel.eateryName = eateryName
                    eateriesListModel.eateryImageMaster = eateryImageMaster
                    eateriesListModel.dishName = dishName
                    eateriesListModel.userName = userName
                    eateriesListModel.userPicture = userPicture
                    eateriesListModel.isLiked = isLiked
                    self.homeListEateriesModel.append(eateriesListModel)

                }
                self.eateriesListDataSource.append(homeListEateriesModel)
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
