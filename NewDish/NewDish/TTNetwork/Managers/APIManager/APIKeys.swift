/*
 Project: SCM Mobile
 Author: SCM Developer
 Date: Mon Nov 27 2017
 
 Copyright © 2017 Smart City Media LLC All rights reserved.
 */

import Foundation

struct APIConfig {
    
    // Config
    static var isProduction: Bool = true
    //
    static var ProductionURL: String = "https://phrasal-charger-215107.appspot.com/api/"
    static var StagingURL: String = "https://phrasal-charger-215107.appspot.com/api/"
    
    static var BaseURL: String {
        if isProduction  {
            return ProductionURL
        } else {
            return StagingURL
        }
    }
    static let  timeoutInterval = 30.0 // In Seconds
}
