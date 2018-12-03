/*
 Project: SCM Mobile
 Author: SCM Developer
 Date: Mon Nov 27 2017
 
 Copyright © 2017 Smart City Media LLC All rights reserved.
 */

import Foundation


@available(iOS 9.0, *)
class TTNetworkManager{
    
    // Shared instance
    static let sharedInstance = TTNetworkManager()
    // Avoid initialization
    private init() {
    }
    
    // MARK: Methods
    // MARK: API Request
    func makeAPIRequest(apiObject: APIBase,
                        completionHandler:@escaping ResponseHandler) {
        
        // Check Cache Control
        if apiObject.enableCacheControl() {
            // Get from Database
            let (requestBinary, isExpired) = APICache.fetchCachedResponse(uniqueKey: apiObject.cacheKey(), apiObject: apiObject)
            if let requestBinary = requestBinary  {
                if let requestObject = NSKeyedUnarchiver.unarchiveObject(with: requestBinary as Data) as? Dictionary<String, AnyObject> {
                    apiObject.parseAPIResponse(response: requestObject)
                    print("*** Content Loaded From Cache ***")
                    completionHandler(requestObject as AnyObject?, nil)
                    guard isExpired == true else {
                        return
                    }
                }
            }
        }
        
        print("*** Server Request Initiated ***")
        // Make Server Request
        APIManager.sharedInstance.initiateRequest(apiObject, apiRequestCompletionHandler: completionHandler)
    }
    
    // MARK: Clear Cache
    func clearCache() {
        APICache.clearAllCachedContent()
    }
}
