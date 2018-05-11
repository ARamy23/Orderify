//  OrderPopupViewController.swift
//  Orderify
//
//  Created by Ahmed Ramy on 4/25/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit
import SVProgressHUD

struct CartItem
{
    var itemID: Int?
    var itemQTY: Int?
    var itemImage: UIImage?
    var itemTitle: String?
    var timestamp: String?
    var price: Double?
}

class OrderPopupViewController: UIViewController, SBCardPopupContent
{
    //MARK:- SBCard Variables
    var popupViewController: SBCardPopupViewController?
    var allowsTapToDismissPopupCard: Bool = true
    var allowsSwipeToDismissPopupCard: Bool = true
    
    static func create(restaurantModel: RestaurantElement, mealModel: Meal, image: UIImage?) -> UIViewController
    {
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OrderPopupViewController") as! OrderPopupViewController
        sb.mealModel = mealModel
        sb.restaurantModel = restaurantModel
        sb.mealImage = image
        return sb
    }

    //MARK:- IBOutlets
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nItemsPickerView: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
    //MARK:- Variables
    var restaurant_id: Int?
    var userID: Int?
    var itemID: Int?
    var itemQTY: Int?
    
    //MARK:- Helping Variables
    var priceOf1 : Double!
    var mealImage: UIImage?
    var mealModel: Meal?
    var restaurantModel: RestaurantElement?
    var delegate: OrdersDelegate?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        setUIFromModel()
        delegate = CartViewController().self
        
    }
    
    func initUI()
    {
        addBorderCorners()
        // maybe will add possible animations here
    }
    
    func addBorderCorners()
    {
        itemNameLabel.layer.masksToBounds = !itemNameLabel.layer.masksToBounds
        itemNameLabel.layer.cornerRadius = 10
        itemImageView.layer.cornerRadius = itemImageView.frame.width/2
        orderButton.layer.cornerRadius = 10
        nItemsPickerView.layer.cornerRadius = nItemsPickerView.frame.height/2
    }
    
    func setUIFromModel()
    {
    
        if restaurantModel != nil
        {
            if mealModel != nil
            {
                itemNameLabel.text = mealModel!.title
                priceOf1 = mealModel?.price
                priceLabel.text = String(mealModel!.price!)
                itemID = mealModel?.id
            }
            
            restaurant_id = restaurantModel?.id
        }
        if mealImage != nil
        {
            itemImageView.image = mealImage
        }
    
    }
    
    @IBAction func didTapAddToCart(_ sender: Any)
    {
        SVProgressHUD.showInfo(withStatus: "Order is Added!")
        let cartItem = CartItem(itemID: itemID,itemQTY: itemQTY ,itemImage: nil, itemTitle: itemNameLabel.text, timestamp: nil, price: Double(priceLabel.text!))
            SharedData.sharedInstance.cartItems.append(cartItem)
            self.popupViewController?.close()
    }
    
}

extension OrderPopupViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = String(row + 1)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        priceLabel.text = String(Double(row+1) * priceOf1!)
        itemQTY = row+1
    }
    
}
