//
//  NDSignInViewController.swift
//  NewDish
//
//  Created by Pradeep on 12/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class NDSignInViewController: NDBaseViewController {

    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var proceedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func proceedButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: kOtpSegueIdentifier, sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
