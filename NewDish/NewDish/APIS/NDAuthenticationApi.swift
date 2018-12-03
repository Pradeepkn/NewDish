//
//  NDAuthenticationApi.swift
//  NewDish
//
//  Created by Pradeep on 12/1/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import Alamofire

class NDAuthenticationApi: APIBase {
    
    var isVerifyNumber = false
    var isVerifyEmail = false
    var isGenerateOtp = false
    var isLoginOtpVerify = false
    var isRegistrationOtpVerify = false
    
    var number: String = ""
    var email: String = ""
    var otp: String = ""
    var password: String = ""
    var name: String = ""
    
    override func urlForRequest() -> String {
        if isVerifyNumber {
            return self.verifyNumberUrl()
        }else if isVerifyEmail {
            return self.verifyEmailUrl()
        }else if isGenerateOtp{
            return self.generateOtpUrl()
        }else if isLoginOtpVerify {
            return self.verifyLoginOtpUrl()
        } else if isRegistrationOtpVerify {
            return self.verifyRegistrationOtpUrl()
        }
        return ""
    }
    
    func verifyNumberUrl() -> String {
        return "\(APIConfig.BaseURL)verifynumber"
    }
    
    func verifyEmailUrl() -> String {
        return "\(APIConfig.BaseURL)verifyemail"
    }
    
    func generateOtpUrl() -> String {
        return "\(APIConfig.BaseURL)generate_otp"
    }
    
    func verifyLoginOtpUrl() ->String {
        return "\(APIConfig.BaseURL)verify_otp_login"
    }
    
    func verifyRegistrationOtpUrl() -> String {
        return "\(APIConfig.BaseURL)verify_otp_register"
    }
    
    // MARK: HTTP method type
    override func requestType() -> HTTPMethod {
        return .post
    }
    
    // MARK: API parameters
    override func requestParameter() -> [String : Any]? {
        if isVerifyNumber {
            return ["number": number]
        }else if isVerifyEmail {
            return ["email": email]
        }else if isGenerateOtp{
            return ["number": number]
        }else if isLoginOtpVerify {
            return ["number": number, "otp":otp]
        } else if isRegistrationOtpVerify {
            return ["number": number,"email": email, "password" : password,"name":name,"otp":otp]
        }
        return [:]
    }
    
    override func customHTTPHeaders() -> Alamofire.HTTPHeaders? {
        return nil
    }
    
    // MARK: Response parser
    override func parseAPIResponse(response: Dictionary<String, AnyObject>?) {
        print(response ?? -1)
        if isRegistrationOtpVerify {
            if response != nil {
                let responseArray = response!["Root"] as? NSArray
                for responseObject in responseArray! {
                    let dictionary : NSDictionary = responseObject as! NSDictionary
                    let dataArray = dictionary["data"] as? NSArray
                    for dataObject in dataArray! {
                        let dataDictionary : NSDictionary = dataObject as! NSDictionary
                        if let accessToken = (dataDictionary["access-token"] as? String) {
                            UserDefaults.standard.set(accessToken, forKey: kAccessTokenIdentifier)
                        }
                    }
                }
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

