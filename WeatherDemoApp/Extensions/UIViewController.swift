//
//  UIViewController.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import UIKit
import SVProgressHUD


extension UIViewController {
    
    func showProgress() {
        SVProgressHUD.show()
    }
    
    @objc 
    func hideProgress() {
        SVProgressHUD.dismiss()
    }
}
