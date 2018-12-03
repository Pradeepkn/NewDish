/*
 Project: SCM Mobile
 Author: SCM Developer
 Date: Mon Nov 27 2017
 
 Copyright © 2017 Smart City Media LLC All rights reserved.
 */

import Foundation
import CoreData

@available(iOS 9.0, *)
extension APICache {

    @NSManaged var createdAt: NSDate?
    @NSManaged var ttl: NSDate?
    @NSManaged var key: String?
    @NSManaged var value: NSData?

}
