//
//  TableViewCell.swift
//  Orderify
//
//  Created by Ahmed Ramy on 4/3/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantTitle: UILabel!
    @IBOutlet weak var restaurantDescription: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    @IBOutlet weak var delieveryTime: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setModel(model: RestaurantElement)
    {
        
//        restaurantImage.image = UIImage(named: model.image!)
        restaurantTitle.text = model.title
        restaurantDescription.text = model.description
        restaurantAddress.text = model.address
        deliveryFee.text = String(describing: model.deliveryFee!)
        delieveryTime.text = String(describing: model.deliveryTimeMins!)
        let imageURLString : String? = model.image
        if imageURLString != nil
        {
            convertToUIImage(imageURLString: imageURLString!)
        }
    }
    
    func convertToUIImage(imageURLString: String)
    {
        DispatchQueue.global(qos: .userInitiated).async
        {
            [unowned self] in
            let url:NSURL = NSURL(string : imageURLString)!
            // It Will turn Into Data
            guard let imageData : NSData = NSData.init(contentsOf: url as URL) else {print("couldn't convert Restaurant image Data"); return;}
            // Data Will Encode into Base64
            let str64 = imageData.base64EncodedData(options: .lineLength64Characters)
            // Now Base64 will Decode Here
            let data: NSData = NSData(base64Encoded: str64 , options: .ignoreUnknownCharacters)!
            // turn  Decoded String into Data
            let dataImage = UIImage(data: data as Data)
            
            
            DispatchQueue.main.async
            { [unowned self] in
                // pass the data image to image View.:)
                self.restaurantImage.image = dataImage
                SharedData.sharedInstance.restaurantImages.append(dataImage)
            }
            
            
        }
    }
}
