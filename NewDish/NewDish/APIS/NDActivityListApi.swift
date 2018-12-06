//
//  NDActivityListApi.swift
//  NewDish
//
//  Created by Kavya KN on 06/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class ActivityListModel: NSObject {
    
    var likesCount : NSNumber = 0
    var commentsCount : NSNumber = 0
    var id : NSNumber = 0
    var type : String = ""
    var userId : NSNumber = 0
    var eateryId : NSNumber = 0
    var dishId : NSNumber = 0
    var mediaType : String = ""
    var mediaUrl : String = ""
    var activityDescription : String = ""
    var createdAt : String = ""
    var eateryName :  String = ""
    var eateryImgMaster : String = ""
    var dishName : String = ""
    var userName : String = ""
    var userPicture : String = ""

}

class NDActivityListApi: APIBase {
    
    var activityId : NSNumber = NSNumber()

    var activityListModel = [ActivityListModel]()
    var activityListDataSource = [[ActivityListModel]]()
    
    override func urlForRequest() -> String {
        return self.getActivityListUrl()
    }
    
    func getActivityListUrl() -> String {
        return "\(APIConfig.BaseURL)activity/"+"\(activityId)"
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
                let activityListArray : NSArray = responseObjects as? NSArray ?? []
                for activityListObject in activityListArray{
                    let dictionary : NSDictionary = activityListObject as! NSDictionary
                    
                    let activityListModel = ActivityListModel()
                    
                    let likesCount = (dictionary["likes_count"] as! NSNumber)
                    let commentsCount = (dictionary["comments_count"] as! NSNumber)
                    let id = (dictionary["id"] as! NSNumber)
                    let type = (dictionary["type"] as! String)
                    let userId = (dictionary["user_id"] as! NSNumber)
                    let eateryId = (dictionary["eatery_id"] as! NSNumber)
                    let dishId = (dictionary["dish_id"] as! NSNumber)
                    let mediaType = (dictionary["media_type"] as! String)
                    let mediaUrl = (dictionary["media_url"] as! String)
                    let activityDescription = (dictionary["description"] as! String)
                    let createdAt = (dictionary["createdAt"] as! String)
                    let eateryName = (dictionary["eatery_name"] as! String)
                    let eateryImageMaster = (dictionary["eatery_img_master"] as! String)
                    let dishName = (dictionary["dish_name"] as! String)
                    let userName = (dictionary["user_name"] as! String)
                    let userPicture = (dictionary["user_picture"] as! String)
                    
                    activityListModel.likesCount = likesCount
                    activityListModel.commentsCount = commentsCount
                    activityListModel.id = id
                    activityListModel.type = type
                    activityListModel.userId = userId
                    activityListModel.eateryId = eateryId
                    activityListModel.dishId = dishId
                    activityListModel.mediaType = mediaType
                    activityListModel.mediaUrl = mediaUrl
                    activityListModel.activityDescription = activityDescription
                    activityListModel.createdAt = createdAt
                    activityListModel.eateryName = eateryName
                    activityListModel.eateryImgMaster = eateryImageMaster
                    activityListModel.dishName = dishName
                    activityListModel.userName = userName
                    activityListModel.userPicture = userPicture
                    self.activityListModel.append(activityListModel)
                }
                self.activityListDataSource.append(activityListModel)
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
