//
//  ViewController.swift
//  Orderify
//
//  Created by Ahmed Ramy on 3/30/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit


class WelcomeViewController: BaseViewController
{
    
    @IBOutlet weak var blur: UIVisualEffectView!
    
    //MARK:- LoginPopup Variables
    @IBOutlet var loginPopup: UIView!
    @IBOutlet weak var login_emailField: UITextField!
    @IBOutlet weak var login_passwordField: UITextField!
    
    //MARK:- RegisterPopup Variables
    @IBOutlet var registerPopup: UIView!
    @IBOutlet weak var userType: UISegmentedControl!
    @IBOutlet weak var register_usernameField: UITextField!
    @IBOutlet weak var register_passwordField: UITextField!
    @IBOutlet weak var register_addressField: UITextField!
    @IBOutlet weak var register_phoneField: UITextField!
    @IBOutlet weak var register_emailField: UITextField!
    
    
    //MARK:- Helping Variables
    var effect : UIVisualEffect!
    
    
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        effect = blur.effect
        blur.effect = nil
        loginPopup.layer.cornerRadius = 5
        registerPopup.layer.cornerRadius = 5
        
        let loggedIn :Bool = UserDefaults.standard.bool(forKey: Defaults.isLogged.rawValue);
        
        if loggedIn
        {
            performSegue(withIdentifier: "goToHome", sender: self)
        }
    }
    
    func animateLoginPopupIn()
    {
        self.view.addSubview(loginPopup)
        loginPopup.center = self.view.center
        
        loginPopup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        loginPopup.alpha = 0
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        loginPopup.addGestureRecognizer(tap)
        UIView.animate(withDuration: 0.4) {
            self.blur.effect = self.effect
            self.loginPopup.alpha = 1
            self.loginPopup.transform = CGAffineTransform.identity
        }
    }
    
    func animateRegisterPopupIn()
    {
        self.view.addSubview(registerPopup)
        registerPopup.center = self.view.center
        
        registerPopup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        loginPopup.alpha = 0
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        registerPopup.addGestureRecognizer(tap)
        UIView.animate(withDuration: 0.4) {
            self.blur.effect = self.effect
            self.registerPopup.alpha = 1
            self.registerPopup.transform = CGAffineTransform.identity
        }
    }
    
    func animateLoginPopupOut()
    {
        UIView.animate(withDuration: 1.3, animations: {
            self.loginPopup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.loginPopup.alpha = 0
            self.blur.effect = nil
        }) { (success:Bool) in
            self.loginPopup.removeFromSuperview()
        }
    }
    
    func animateRegisterPopupOut()
    {
        UIView.animate(withDuration: 1.3, animations: {
            self.registerPopup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.registerPopup.alpha = 0
            self.blur.effect = nil
        }) { (success: Bool) in
            self.registerPopup.removeFromSuperview()
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any)
    {
        APIManager().login(withEmail: login_emailField.text!, password: login_passwordField.text!) { (user) in
            UserDefaults.standard.set(true, forKey:Defaults.isLogged.rawValue)
            UserDefaults.standard.set(user?.id, forKey: Defaults.id.rawValue)
            UserDefaults.standard.set(user?.email, forKey: Defaults.email.rawValue)
            UserDefaults.standard.set(user?.username, forKey: Defaults.username.rawValue)
            UserDefaults.standard.set(user?.phone, forKey: Defaults.phone.rawValue)
            UserDefaults.standard.set(user?.address, forKey: Defaults.address.rawValue)
            UserDefaults.standard.set(user?.owner, forKey:Defaults.isOwner.rawValue)
            self.performSegue(withIdentifier: "goToHome", sender: nil)
            
        }
        
        animateLoginPopupOut()
        
    }
    
    @IBAction func loginPopupButtonPressed(_ sender: Any)
    {
        animateLoginPopupIn()
    }
    
    
    @IBAction func registerButtonPressed(_ sender: Any)
    {
        animateRegisterPopupOut()
        
        if(register_usernameField.text?.count != 0 &&
            register_passwordField.text?.count != 0 &&
            register_phoneField.text?.count != 0 &&
            register_addressField.text?.count != 0 &&
            register_emailField.text?.count != 0)
        {
            
            /*
             username => String,
             password => String,
             phone => String,
             email => String,
             address => String,
             owner => Boolean
             */
            let ownerUser = userType.selectedSegmentIndex == 1
            let params = ["username": register_usernameField.text!,
                          "password": register_passwordField.text!,
                          "phone": register_phoneField.text!,
                          "email":register_emailField.text!,
                          "address": register_addressField.text!,
                          "owner": ownerUser] as [String : Any]
            let status = APIManager().register(params: params)
            
            animateLoginPopupIn()
        }
    }
    
    @IBAction func registerPopupButtonPressed(_ sender: Any)
    {
        animateRegisterPopupIn()
    }
    
    
}

