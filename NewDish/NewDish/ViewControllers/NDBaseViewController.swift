//
//  NDBaseViewController.swift
//  NewDish
//
//  Created by Pradeep on 12/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit

struct ScreenSize {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_5_OR_LESS = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 667.0
    static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
}

typealias ResponseCallback = (Bool) -> ()

let kOtpSegueIdentifier = "OtpSegueIdentifier"
let kSignInSegueIdentifier = "SignInSegueIdentifier"
let kSignUpSegueIdentifier = "SignUpSegueIdentifier"

class NDBaseViewController: UIViewController {
    
    static let sharedInstance = NDBaseViewController()
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addNavigationImage (imageName : String) {
        navigationItem.titleView = self.getNavigationImage(imageName: imageName)
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func getNavigationImage(imageName : String) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 5, width: 130, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: imageName)
        imageView.image = image
        return imageView
    }
    
    func updateBackButton(imageName : String, buttonTitle : String) {
        let yourBackImage = UIImage(named: imageName)
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.backItem?.title = buttonTitle
    }
    
    func showActivityIndicatory(uiView: UIView) -> UIActivityIndicatorView {
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.style = UIActivityIndicatorView.Style.whiteLarge
        actInd.tintColor = UIColor.red
        uiView.addSubview(actInd)
        actInd.startAnimating()
        return actInd
    }
    
    func showActivityIndicatorOn(uiView : UIView)  {
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.style = UIActivityIndicatorView.Style.white
        actInd.tintColor = UIColor.red
        uiView.addSubview(actInd)
        actInd.startAnimating()
    }
    
    func hideActivityIndicator()  {
        actInd.stopAnimating()
        actInd.removeFromSuperview()
    }
}

extension UITextField {
    func setBottomBorder(color : UIColor) {
        self.borderStyle = UITextField.BorderStyle.none;
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

extension UserDefaults {
    func contains(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}

extension UIViewController {
    func setNavigationBarItem() {
//        var image : UIImage = UIImage(named: "menuIcon")!
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
    }
}

extension UIButton {
    func updateButtonImageColor(color: UIColor = UIColor.white) {
        self.setTitleColor(color, for: UIControl.State.normal)
        let image = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(image, for: .normal)
        self.tintColor = color
    }
}

extension UIImage {
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        
        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

