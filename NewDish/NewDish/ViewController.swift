//
//  ViewController.swift
//  NewDish
//
//  Created by Pradeep on 11/30/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.verifyNumberApi()
    }

    func verifyNumberApi(){
        let simNumberApi = NDAuthenticationApi()
        simNumberApi.isVerifyNumber = true
        simNumberApi.number = "8349747761"
        if #available(iOS 9.0, *) {
            TTNetworkManager.sharedInstance.makeAPIRequest(apiObject: simNumberApi, completionHandler: { (response, error) in
                if let error = error as NSError? {
                    print(error.userInfo)
                }else {
                    print(response ?? "Response")
                }
            })
        }
    }
}
