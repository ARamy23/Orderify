//
//  CartRowsSingleton.swift
//  Orderify
//
//  Created by Ahmed Ramy on 4/28/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation
import UIKit

class SharedData
{
    static let sharedInstance = SharedData()
    
    var cartItems : [CartItem] = []
    var restaurantImages: [UIImage?] = []
    var mealsImages: [UIImage?] = []
    private init()
    {
        
    }
    
    
}
