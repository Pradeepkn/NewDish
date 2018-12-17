//
//  NDOtpViewController.swift
//  NewDish
//
//  Created by Pradeep on 12/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class NDOtpViewController: NDBaseViewController {
    
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var firstDigit: UIButton!
    @IBOutlet weak var secondDigit: UIButton!
    @IBOutlet weak var thirdDigit: UIButton!
    @IBOutlet weak var fourthDigit: UIButton!
    @IBOutlet weak var indicator1: UIView!
    @IBOutlet weak var indicator2: UIView!
    @IBOutlet weak var indicator3: UIView!
    @IBOutlet weak var indicator4: UIView!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.otpTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resentButtonClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func confirmButtonClicked(_ sender: UIButton) {
        
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

extension NDOtpViewController : UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func resetIndicators()  {
        indicator1.backgroundColor = UIColor.lightGray
        indicator2.backgroundColor = UIColor.lightGray
        indicator3.backgroundColor = UIColor.lightGray
        indicator4.backgroundColor = UIColor.lightGray
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.resetIndicators()
        var textFieldString : String = textField.text ?? ""
        
        var characterCount = 0
        if string == "" {
            if ((textField.text?.count)! > 0) {
                textFieldString = String((textField.text?.dropLast())!)
                characterCount = textFieldString.count - 1
            }
        }else {
            characterCount = textFieldString.count
        }
        switch characterCount {
        case 0:
            if string.count > 0 {
                firstDigit.setTitle(string, for: .normal)
            }
            secondDigit.setTitle("", for: .normal)
            thirdDigit.setTitle("", for: .normal)
            fourthDigit.setTitle("", for: .normal)
            indicator1.backgroundColor = UIColor.red
        case 1:
            if string.count > 0 {
                secondDigit.setTitle(string, for: .normal)
            }
            thirdDigit.setTitle("", for: .normal)
            fourthDigit.setTitle("", for: .normal)
            indicator1.backgroundColor = UIColor.red
            indicator2.backgroundColor = UIColor.red
        case 2:
            if string.count > 0 {
                thirdDigit.setTitle(string, for: .normal)
            }
            fourthDigit.setTitle("", for: .normal)
            indicator1.backgroundColor = UIColor.red
            indicator2.backgroundColor = UIColor.red
            indicator3.backgroundColor = UIColor.red
        case 3:
            if string.count > 0 {
                fourthDigit.setTitle(string, for: .normal)
            }
            indicator1.backgroundColor = UIColor.red
            indicator2.backgroundColor = UIColor.red
            indicator3.backgroundColor = UIColor.red
            indicator4.backgroundColor = UIColor.red
        case -1:
            firstDigit.setTitle(string, for: .normal)
            self.resetIndicators()
        default:
            indicator1.backgroundColor = UIColor.red
            indicator2.backgroundColor = UIColor.red
            indicator3.backgroundColor = UIColor.red
            indicator4.backgroundColor = UIColor.red
            return false
        }
        return true
    }
}
