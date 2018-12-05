//
//  NDRestaurantListApi.swift
//  NewDish
//
//  Created by Kavya KN on 05/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class RestaurantListModel : NSObject {
    var id : NSNumber = 0
    var title : String = ""
    var restaurantDescription : String = ""
    var cityId : NSNumber = 0
    var eateriesModel : [EateriesListModel] = [EateriesListModel]()
    var dishesModel : [DishesModel] = [DishesModel]()
}

class EateriesListModel : NSObject {
    var id : NSNumber = 0
    var name : String = ""
    var uniqueName : String = ""
    var optUniqueId : String = ""
    var costForTwo : NSNumber = 0
    var address : String = ""
    var type : NSNumber = 0
    var latitude : NSNumber = 0
    var longitude : NSNumber = 0
    var geoLocation : GeoLocationModel = GeoLocationModel()
    var phoneNumber1 : String = ""
    var phoneNumber2 : String = ""
    var forceOpenClose : Bool = false
    var imageMaster : String = ""
    var businessHours : [String] = [String]()
    var active : Bool = false
    var menu : [MenuModel] = [MenuModel]()
    var recommended : [String] = [String]()
    var localityId : NSNumber = 0
    var cityId : NSNumber = 0
    var createdAt : String = ""
    var updatedAt : String = ""
    var collectionEateries : CollectionEateriesModel = CollectionEateriesModel()
}

class GeoLocationModel: NSObject {
    var type : String = ""
    var coordinates : [NSNumber] = [NSNumber]()
}

class MenuModel: NSObject {
    var name : String = ""
    var dishes : [String] = [String]()
    var divisions : [String] = [String]()
}

class CollectionEateriesModel: NSObject {
    var createdAt : String = ""
    var updatedAt : String = ""
    var collectionId : NSNumber = 0
    var eateryId :  NSNumber = 0
}

class DishesModel : NSObject {
}

class NDRestaurantListApi: APIBase {

    var restaurantListDataSource = [RestaurantListModel]()
    
    override func urlForRequest() -> String {
        return self.getRestaurantListUrl()
    }
    
    func getRestaurantListUrl() -> String {
        return "\(APIConfig.BaseURL)explore?city_id=1"
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
                
                let restaurantListModel = RestaurantListModel()
                
                let id = (dictionary["id"] as! NSNumber)
                let title = (dictionary["title"] as! String)
                let restaurantDescription = (dictionary["description"] as! String)
                let cityId = (dictionary["city_id"] as! NSNumber)
                restaurantListModel.id = id
                restaurantListModel.title = title
                restaurantListModel.restaurantDescription = restaurantDescription
                restaurantListModel.cityId = cityId

                let eateriesArray = dictionary["eateries"] as? NSMutableArray
    
                for eateries in eateriesArray ?? [] {
                    let eaterieDictionary : NSDictionary = eateries as! NSDictionary

                    let eateriesListModel = EateriesListModel()
                    
                    let id = (eaterieDictionary["id"] as! NSNumber)
                    let name = (eaterieDictionary["name"] as! String)
                    let uniqueName = (eaterieDictionary["unique_name"] as! String)
                    let optUniqueId = (eaterieDictionary["opt_unique_id"] as! String)
                    let costForTwo = (eaterieDictionary["cost_for_two"] as! NSNumber)
                    let address = (eaterieDictionary["address"] as! String)
                    let type = (eaterieDictionary["type"] as! NSNumber)
                    let latitude = (eaterieDictionary["latitude"] as! NSNumber)
                    let longitude = (eaterieDictionary["longitude"] as! NSNumber)
                    
                    eateriesListModel.id = id
                    eateriesListModel.name = name
                    eateriesListModel.uniqueName = uniqueName
                    eateriesListModel.optUniqueId = optUniqueId
                    eateriesListModel.costForTwo = costForTwo
                    eateriesListModel.address = address
                    eateriesListModel.type = type
                    eateriesListModel.latitude = latitude
                    eateriesListModel.longitude = longitude

                    let geoLocationModel : GeoLocationModel = GeoLocationModel()
                    let geoLocationObject = eaterieDictionary["geo_location"] as! NSDictionary
                    let geoLocationtype = geoLocationObject["type"] as! String
                    let coordinates = geoLocationObject["coordinates"] as! [NSNumber]
                    geoLocationModel.type = geoLocationtype
                    for coordinate in coordinates {
                        geoLocationModel.coordinates.append(coordinate)
                    }
                    
                    eateriesListModel.geoLocation = geoLocationModel
                    
                    let phoneNumber1 = (eaterieDictionary["phone1"] as! String)
                    let phoneNumber2 = (eaterieDictionary["phone2"] as! String)
                    let forceOpenClose = (eaterieDictionary["force_open_close"] as! Bool)
                    let imageMaster = (eaterieDictionary["img_master"] as! String)
                    
                    eateriesListModel.phoneNumber1 = phoneNumber1
                    eateriesListModel.phoneNumber2 = phoneNumber2
                    eateriesListModel.forceOpenClose = forceOpenClose
                    eateriesListModel.imageMaster = imageMaster


                    let businessHours = (eaterieDictionary["business_hours"] as! [String])
                    for businessHour in businessHours {
                        eateriesListModel.businessHours.append(businessHour)
                    }
                    
                    let active = (eaterieDictionary["active"] as! Bool)
                    eateriesListModel.active = active
                    
                    let menuArray = eaterieDictionary["menu"] as? NSMutableArray
                    
                    for menus in menuArray ?? [] {
                        let menuDictionary : NSDictionary = menus as! NSDictionary
                        
                        let menuListModel = MenuModel()
                        
                        let name = menuDictionary["name"] as! String
                        menuListModel.name = name
                        let dishes = (menuDictionary["dishes"] as! [String])
                        for dishe in dishes {
                            menuListModel.dishes.append(dishe)
                        }
                        let divisions = (menuDictionary["divisions"] as! [String])
                        for division in divisions {
                            menuListModel.divisions.append(division)
                        }
                        eateriesListModel.menu.append(menuListModel)
                    }
                    let recommended = (eaterieDictionary["recommended"] as! [String])
                    for recommend in recommended {
                        eateriesListModel.recommended.append(recommend)
                    }

                    let localityId = (eaterieDictionary["locality_id"] as! NSNumber)
                    let cityId = (eaterieDictionary["city_id"] as! NSNumber)
                    let createdAt = (eaterieDictionary["createdAt"] as! String)
                    let updatedAt = (eaterieDictionary["updatedAt"] as! String)
                    eateriesListModel.localityId = localityId
                    eateriesListModel.cityId = cityId
                    eateriesListModel.createdAt = createdAt
                    eateriesListModel.updatedAt = updatedAt
                    
                    
                    let collectionEateriesModel : CollectionEateriesModel = CollectionEateriesModel()
                    let collectionEateriesObject = eaterieDictionary["collection_eateries"] as! NSDictionary
                    let collectionEateriesCreatedAt = collectionEateriesObject["createdAt"] as! String
                    let collectionEateriesUpdatedAt = collectionEateriesObject["updatedAt"] as! String
                    let collectionId = collectionEateriesObject["collection_id"] as! NSNumber
                    let eateryId = collectionEateriesObject["eatery_id"] as! NSNumber
                    collectionEateriesModel.createdAt = collectionEateriesCreatedAt
                    collectionEateriesModel.updatedAt = collectionEateriesUpdatedAt
                    collectionEateriesModel.collectionId = collectionId
                    collectionEateriesModel.eateryId = eateryId
                    
                    eateriesListModel.collectionEateries = collectionEateriesModel
                    
                    restaurantListModel.eateriesModel.append(eateriesListModel)
                }
                
                let dishesArray = dictionary["dishes"] as? NSMutableArray
                
                for dishe in dishesArray ?? [] {
                    let disheDictionary : NSDictionary = dishe as! NSDictionary
                    
                    let disheModel = DishesModel()
                    restaurantListModel.dishesModel.append(disheModel)
                }
                self.restaurantListDataSource.append(restaurantListModel)
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
