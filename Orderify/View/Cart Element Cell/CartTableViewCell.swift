//
//  CartTableViewCell.swift
//  Orderify
//
//  Created by Ahmed Ramy on 4/27/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var mealPriceLabel: UILabel!
    @IBOutlet weak var mealStatusLabel: UILabel!
    @IBOutlet weak var mealTimestampLabel: UILabel!
    @IBOutlet weak var mealQTYLabel: UILabel!
    var itemID: Int!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        mealImageView.layer.cornerRadius = mealImageView.frame.height/2
    }

    func setModel(model: CartItem)
    {
        mealTitleLabel.text = model.itemTitle
        mealImageView.image = model.itemImage
        mealPriceLabel.text = String(model.price!)
        mealTimestampLabel.text = model.timestamp
        mealQTYLabel.text = String(model.itemQTY!)
        itemID = model.itemID
    }
    
}
