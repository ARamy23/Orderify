//
//  API Manager.swift
//  Orderify
//
//  Created by Ahmed Ramy on 3/30/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Alamofire
import SwiftyJSON
import SVProgressHUD

class APIManager
{
    //MARK:- Instance Variables
    let URL = Constants.APIURL.rawValue
    var restaurant = [Restaurant]()
    //MARK:- Networking
    /********************************************/
    //MARK:- POST Requests
    func login(withEmail email: String, password: String, completionHandler: @escaping (UserData?)  -> ())
    {
        Alamofire.request(URL + Constants.loginExtension.rawValue, method: .get, parameters: ["email": email, "password": password]).responseUser { (response) in
            if response.result.isSuccess
            {
                let result = response.data
                do
                {
                    let user = try JSONDecoder().decode(User.self, from: result!)
                    return completionHandler(user.data)
                }
                catch
                {
                    print("retrieving data failed")
                    return completionHandler(nil)
                }
            }
        }
    }
    
    func register(params: [String: Any]) -> Bool
    {
        var status : Bool = false
        Alamofire.request(URL + Constants.registerExtension.rawValue, method: .post, parameters: params).responseJSON { (response) in
            
            status = response.result.isSuccess
            print(JSON(response.result.value))
        }
        return status
    }
    
    func addOrder(params: [String: Any],completionHandler: @escaping (_ errorCode: Int?)->())
    {
        Alamofire.request(URL + Constants.addOrderExtension.rawValue, method: .post, parameters: params).responseRestaurant { (response) in
            if response.result.isSuccess
            {
                let result = response.data
                do
                {
                    let errorCode = try JSONDecoder().decode(Restaurant.self, from: result!)
                    return completionHandler(errorCode.errorCode)
                }
                catch
                {
                    print("error retrieving the orders!, check your connection")
                    return completionHandler(nil)
                }
            }
        }
    }
    //MARK:- GET Requests
    /********************************************/
    
    func getRestaurants(completionHandler: @escaping (_ restaurant: Restaurant?)-> ())
    {
        Alamofire.request(Constants.APIURL.rawValue + Constants.getRestaurantsExtension.rawValue, method: .get, parameters: [:]).responseRestaurant
        { (response) in
            if response.result.isSuccess
            {
                let result = response.data
                do
                {
                    let restaurants = try JSONDecoder().decode(Restaurant.self, from: result!)
                    return completionHandler(restaurants)
                }
                catch
                {
                    print("error retrieving the restaurants!")
                    return completionHandler(nil)
                }
                
            }
            else
            {
                print("request Failed")
                return completionHandler(nil)
            }
        }
        
    
    }
    
}
