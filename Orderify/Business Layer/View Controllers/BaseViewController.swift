//
//  BaseViewController.swift
//  Session 11
//
//  Created by Mahmoud Tarek on 2/21/18.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.hideLoading()
    }
    
    //MARK: Show Alert
    
    func showAlert(title: String = "Error", msg: String) {
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: Keyboard handling
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: Loading View
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    func showLoading() {
        
        overlayView.frame = CGRect(x:0, y:0, width:80, height:80)
        
        overlayView.center = CGPoint(x: self.view.frame.width / 2.0, y: self.view.frame.height / 2.0)
        
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        overlayView.clipsToBounds = true
        
        overlayView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x:0, y:0, width:40, height:40)
        
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        
        overlayView.addSubview(activityIndicator)
        
        self.view.addSubview(overlayView)
        
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }

    
    

}
