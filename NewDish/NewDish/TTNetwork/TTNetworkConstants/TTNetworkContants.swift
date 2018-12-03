/*
 Project: SCM Mobile
 Author: SCM Developer
 Date: Mon Nov 27 2017
 
 Copyright © 2017 Smart City Media LLC All rights reserved.
 */

import Foundation


/// MARK : Database
struct Database {
    struct Entities {
        static let APICache = "APICache"
    }
    
    struct APICacheFields {
        static let Key = "key"
        static let Value = "value"
        static let CreatedAt = "createdAt"
        static let ExpiresAt = "expiresAt"
    }
}
