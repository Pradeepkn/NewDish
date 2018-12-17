//
//  NDEateriesDetailsApi.swift
//  NewDish
//
//  Created by Kavya KN on 12/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class EateriesDetailsModel : NSObject {
    var id : NSNumber = 0
    var name : String = ""
    var uniqueName : String = ""
    var optUniqueId : String = ""
    var costForTwo : NSNumber = 0
    var address : String = ""
    var type : NSNumber = 0
    var latitude : NSNumber = 0
    var longitude : NSNumber = 0
    var geoLocation : EateriesDetailGeoLocationModel = EateriesDetailGeoLocationModel()
    var phoneNumber1 : String = ""
    var phoneNumber2 : String = ""
    var forceOpenClose : Bool = false
    var imageMaster : String = ""
    var businessHours : [String] = [String]()
    var active : Bool = false
    var menu : [EateriesDetailMenuModel] = [EateriesDetailMenuModel]()
    var recommended : [String] = [String]()
    var localityId : NSNumber = 0
    var cityId : NSNumber = 0
    var createdAt : String = ""
    var updatedAt : String = ""
    var city : EateriesDetailDishCityModel = EateriesDetailDishCityModel()
    var locality : EateriesDetailLocalityModel = EateriesDetailLocalityModel()
    var establishments : [EstablishmentsModel] = [EstablishmentsModel]()
    var features : [FeaturesModel] = [FeaturesModel]()
    var Cuisine : [CuisineModel] = [CuisineModel]()
    var dishes : [EateryDishesListModel] = [EateryDishesListModel]()
    var followerCount : NSNumber = 0
    var dealCount : NSNumber = 0
    var isFollowing : Bool = false
}

class EateriesDetailGeoLocationModel: NSObject {
    var type : String = ""
    var coordinates : [NSNumber] = [NSNumber]()
}

class EateriesDetailMenuModel: NSObject {
    var name : String = ""
    var dishes : [String] = [String]()
    var divisions : [EateriesDetailDivisions] = [EateriesDetailDivisions]()
}

class EateriesDetailDivisions : NSObject {
    var name : String = ""
    var dishes : [String] = [String]()
    var subDivisions : [String] = [String]()
}

class EateriesDetailDishCityModel: NSObject {
    var name : String = ""
    var id : NSNumber = 0
}

class EateriesDetailLocalityModel: NSObject {
    var id : NSNumber = 0
    var name : String = ""
    var cityId : NSNumber = 0
}

class EstablishmentsModel: NSObject {
    var id : NSNumber = 0
    var name : String = ""
    var eateryEstablishment : EateryEastablishmentModel = EateryEastablishmentModel()
}

class EateryEastablishmentModel: NSObject {
    var establishmentId : NSNumber = 0
    var eateryId : NSNumber = 0
}

class EateriesDetailCollectionEateriesModel: NSObject {
    var createdAt : String = ""
    var updatedAt : String = ""
    var collectionId : NSNumber = 0
    var eateryId :  NSNumber = 0
}

class EateriesDetailDishesModel : NSObject {
}

class FeaturesModel: NSObject {
    var id : NSNumber = NSNumber()
    var name : String = String()
    var eateryFeatures : EateryFeaturesModel = EateryFeaturesModel()
}

class EateryFeaturesModel: NSObject {
    var featureId : NSNumber = 0
    var eateryId : NSNumber = 0
}

class CuisineModel: NSObject {
    var id : NSNumber = NSNumber()
    var name : String = String()
    var eateryCuisine : EateryCuisineModel = EateryCuisineModel()
}

class EateryCuisineModel: NSObject {
    var cuisineId : NSNumber = 0
    var eateryId : NSNumber = 0
}

class EateryDishesListModel: NSObject {
    var id : NSNumber = 0
    var name : String = ""
    var eateryId : NSNumber = 0
    var dishDescription : String = ""
    var price : NSNumber = 0
    var multiPrice : NSNumber = 0
    var isActive : Bool = false
    var imageDish : String = ""
    var videoDish : String = ""
    var localityBest : String = ""
    var cityBest : String = ""
    var createdAt : String = ""
    var updatedAt : String = ""
}

class NDEateriesDetailsApi: APIBase {
    
    var eateriesDetailsDataSource = EateriesDetailsModel()
    
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
                
                let eateriesDetailDictionary = dictionary["eatery_details"] as! NSDictionary
                
                let eateriesDetailModel = EateriesDetailsModel()
                
                let id = (eateriesDetailDictionary["id"] as! NSNumber)
                let name = (eateriesDetailDictionary["name"] as! String)
                let uniqueName = (eateriesDetailDictionary["unique_name"] as! String)
                let optUniqueId = (eateriesDetailDictionary["opt_unique_id"] as! String)
                let costForTwo = (eateriesDetailDictionary["cost_for_two"] as! NSNumber)
                let address = (eateriesDetailDictionary["address"] as! String)
                let type = (eateriesDetailDictionary["type"] as! NSNumber)
                let latitude = (eateriesDetailDictionary["latitude"] as! NSNumber)
                let longitude = (eateriesDetailDictionary["longitude"] as! NSNumber)
                
                eateriesDetailModel.id = id
                eateriesDetailModel.name = name
                eateriesDetailModel.uniqueName = uniqueName
                eateriesDetailModel.optUniqueId = optUniqueId
                eateriesDetailModel.costForTwo = costForTwo
                eateriesDetailModel.address = address
                eateriesDetailModel.type = type
                eateriesDetailModel.latitude = latitude
                eateriesDetailModel.longitude = longitude
                
                let geoLocationModel : EateriesDetailGeoLocationModel = EateriesDetailGeoLocationModel()
                let geoLocationObject = eateriesDetailDictionary["geo_location"] as! NSDictionary
                let geoLocationtype = geoLocationObject["type"] as! String
                let coordinates = geoLocationObject["coordinates"] as! [NSNumber]
                geoLocationModel.type = geoLocationtype
                for coordinate in coordinates {
                    geoLocationModel.coordinates.append(coordinate)
                }
                
                eateriesDetailModel.geoLocation = geoLocationModel
                
                
                let phoneNumber1 = (eateriesDetailDictionary["phone1"] as! String)
                let phoneNumber2 = (eateriesDetailDictionary["phone2"] as! String)
                let forceOpenClose = (eateriesDetailDictionary["force_open_close"] as! Bool)
                let imageMaster = (eateriesDetailDictionary["img_master"] as! String)
                
                eateriesDetailModel.phoneNumber1 = phoneNumber1
                eateriesDetailModel.phoneNumber2 = phoneNumber2
                eateriesDetailModel.forceOpenClose = forceOpenClose
                eateriesDetailModel.imageMaster = imageMaster
                
                
                let businessHours = (eateriesDetailDictionary["business_hours"] as! [String])
                for businessHour in businessHours {
                    eateriesDetailModel.businessHours.append(businessHour)
                }
                
                let active = (eateriesDetailDictionary["active"] as! Bool)
                eateriesDetailModel.active = active
                
                let menuArray = eateriesDetailDictionary["menu"] as? NSMutableArray
                
                for menus in menuArray ?? [] {
                    let menuDictionary : NSDictionary = menus as! NSDictionary
                    
                    let menuListModel = EateriesDetailMenuModel()
                    
                    let name = menuDictionary["name"] as! String
                    menuListModel.name = name
                    let dishes = (menuDictionary["dishes"] as! [String])
                    for dishe in dishes {
                        menuListModel.dishes.append(dishe)
                    }
                    
                    let divisions = menuDictionary["divisions"] as? NSMutableArray
                    for division in divisions ?? [] {
                        let divisionsDictionary : NSDictionary = division as! NSDictionary
                        
                        let eateriesDetailDivisions = EateriesDetailDivisions()
                        
                        let name = divisionsDictionary["name"] as! String
                        eateriesDetailDivisions.name = name
                        let dishes = (divisionsDictionary["dishes"] as! [String])
                        for dishe in dishes {
                            eateriesDetailDivisions.dishes.append(dishe)
                        }
                        let subDivisions = (divisionsDictionary["subDivisions"] as! [String])
                        for subDivision in subDivisions {
                            eateriesDetailDivisions.subDivisions.append(subDivision)
                        }
                        
                        menuListModel.divisions.append(eateriesDetailDivisions)
                    }
                    eateriesDetailModel.menu.append(menuListModel)
                }
                
                let recommended = (eateriesDetailDictionary["recommended"] as! [String])
                for recommend in recommended {
                    eateriesDetailModel.recommended.append(recommend)
                }
                
                let localityId = (eateriesDetailDictionary["locality_id"] as! NSNumber)
                let cityId = (eateriesDetailDictionary["city_id"] as! NSNumber)
                let createdAt = (eateriesDetailDictionary["createdAt"] as! String)
                let updatedAt = (eateriesDetailDictionary["updatedAt"] as! String)
                eateriesDetailModel.localityId = localityId
                eateriesDetailModel.cityId = cityId
                eateriesDetailModel.createdAt = createdAt
                eateriesDetailModel.updatedAt = updatedAt
                
                let cityData = eateriesDetailDictionary["city"] as! NSDictionary
                let cityModel = EateriesDetailDishCityModel()
                cityModel.id = cityData["id"] as! NSNumber
                cityModel.name = cityData["name"] as! String
                
                eateriesDetailModel.city = cityModel
                
                let localityData = eateriesDetailDictionary["locality"] as! NSDictionary
                let localityModel = EateriesDetailLocalityModel()
                localityModel.id = localityData["id"] as! NSNumber
                localityModel.name = localityData["name"] as! String
                localityModel.cityId = localityData["city_id"] as! NSNumber
                
                eateriesDetailModel.locality = localityModel
                
                let establishmentArray = dictionary["establishments"] as? NSMutableArray
                
                for establishment in establishmentArray ?? [] {
                    let establishmentDictionary : NSDictionary = establishment as! NSDictionary
                    
                    let establishmentsListModel = EstablishmentsModel()
                    
                    let id = (establishmentDictionary["id"] as! NSNumber)
                    let name = (establishmentDictionary["name"] as! String)
                    
                    let eateryEastablishmentData = eateriesDetailDictionary["eatery_establishments"] as! NSDictionary
                    let eateryEastablishmentModel = EateryEastablishmentModel()
                    eateryEastablishmentModel.establishmentId = eateryEastablishmentData["establishment_id"] as! NSNumber
                    eateryEastablishmentModel.eateryId = eateryEastablishmentData["eatery_id"] as! NSNumber
                    
                    establishmentsListModel.id = id
                    establishmentsListModel.name = name
                    establishmentsListModel.eateryEstablishment = eateryEastablishmentModel
                    
                    eateriesDetailModel.establishments.append(establishmentsListModel)
                }
                
                let featuresArray = dictionary["features"] as? NSMutableArray
                
                for feature in featuresArray ?? [] {
                    let featureDictionary : NSDictionary = feature as! NSDictionary
                    
                    let featuresListModel = FeaturesModel()
                    
                    let id = (featureDictionary["id"] as! NSNumber)
                    let name = (featureDictionary["name"] as! String)
                    
                    let eateryFeatureData = eateriesDetailDictionary["eatery_features"] as! NSDictionary
                    let eateryFeatureModel = EateryFeaturesModel()
                    eateryFeatureModel.featureId = eateryFeatureData["feature_id"] as! NSNumber
                    eateryFeatureModel.eateryId = eateryFeatureData["eatery_id"] as! NSNumber
                    
                    featuresListModel.id = id
                    featuresListModel.name = name
                    featuresListModel.eateryFeatures = eateryFeatureModel
                    
                    eateriesDetailModel.features.append(featuresListModel)
                }
                
                
                let cuisinesArray = dictionary["cuisines"] as? NSMutableArray
                
                for cuisine in cuisinesArray ?? [] {
                    let cuisineDictionary : NSDictionary = cuisine as! NSDictionary
                    
                    let cuisineModel = CuisineModel()
                    
                    let id = (cuisineDictionary["id"] as! NSNumber)
                    let name = (cuisineDictionary["name"] as! String)
                    
                    let cuisineData = eateriesDetailDictionary["eatery_cuisines"] as! NSDictionary
                    let eateryCuisineModel = EateryCuisineModel()
                    eateryCuisineModel.cuisineId = cuisineData["cuisine_id"] as! NSNumber
                    eateryCuisineModel.eateryId = cuisineData["eatery_id"] as! NSNumber
                    
                    cuisineModel.id = id
                    cuisineModel.name = name
                    cuisineModel.eateryCuisine = eateryCuisineModel
                    
                    eateriesDetailModel.Cuisine.append(cuisineModel)
                }
                
                let dishesArray = dictionary["dishes"] as? NSMutableArray
                
                for dish in dishesArray ?? [] {
                    let dishDictionary : NSDictionary = dish as! NSDictionary
                    
                    let dishesListModel = EateryDishesListModel()
                    
                    let id = (dishDictionary["id"] as! NSNumber)
                    let name = (dishDictionary["name"] as! String)
                    let eateryId = (dishDictionary["eatery_id"] as! NSNumber)
                    let dishDescription = (dishDictionary["description"] as! String)
                    let price = (dishDictionary["price"] as! NSNumber)
                    let multiPrice = (dishDictionary["multi_price"] as! NSNumber)
                    let isActive = (dishDictionary["active"] as! Bool)
                    let imageDish = (dishDictionary["img_dish"] as! String)
                    let videoDish = (dishDictionary["video_dish"] as! String)
                    let localityBest = (dishDictionary["locality_best"] as! String)
                    let cityBest = (dishDictionary["city_best"] as! String)
                    let createdAt = (dishDictionary["createdAt"] as! String)
                    let updatedAt = (dishDictionary["updatedAt"] as! String)
                    
                    
                    dishesListModel.id = id
                    dishesListModel.name = name
                    dishesListModel.eateryId = eateryId
                    dishesListModel.dishDescription = dishDescription
                    dishesListModel.price = price
                    dishesListModel.multiPrice = multiPrice
                    dishesListModel.isActive = isActive
                    dishesListModel.imageDish = imageDish
                    dishesListModel.videoDish = videoDish
                    dishesListModel.localityBest = localityBest
                    dishesListModel.cityBest = cityBest
                    dishesListModel.createdAt = createdAt
                    dishesListModel.updatedAt = updatedAt
                    
                    eateriesDetailModel.dishes.append(dishesListModel)
                }
                
                eateriesDetailModel.followerCount = dictionary["follower_count"] as! NSNumber
                eateriesDetailModel.dealCount = dictionary["deal_count"] as! NSNumber
                eateriesDetailModel.isFollowing = dictionary["is_following"] as! Bool
                
                self.eateriesDetailsDataSource = eateriesDetailModel
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
