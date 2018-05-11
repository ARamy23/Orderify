//
//  Constants.swift
//  Otlob Clone
//
//  Created by Ahmed Ramy on 3/11/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

enum Constants : String {
    
    case APIURL = "http://mahmoudtarek.info/course/apis/otlob"
    case loginExtension = "/login.php"
    case registerExtension = "/register.php"
    case addRestaurantExtension = "/addrestaurant.php"
    case addItemExtension = "/additem.php"
    case getRestaurantOrdersExtension = "/restaurant_orders.php"
    case getRestaurantsExtension = "/restaurants.php"
    case addOrderExtension = "/addorder.php"
    
}


// User defaults stored in enum to enable ease-access
enum Defaults: String {
    
    case isLogged = "isLogged"
    case id = "id"
    case username = "Username"
    case email = "email"
    case phone = "phone"
    case isOwner = "owner"
    case address = "address"
    
}
