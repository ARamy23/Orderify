//
//  RestaurantElementCollectionViewCell.swift
//  Orderify
//
//  Created by Ahmed Ramy on 4/5/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class RestaurantElementCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    var id: Int? = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setModel(model: Meal)
    {
        id = model.id
        title.text = model.title!
        descriptionLabel.text = model.description
        price.text = "\(model.price!) EGP"
        let imageURLString = model.image
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
                SharedData.sharedInstance.mealsImages.append(dataImage)
                
                DispatchQueue.main.async
                    { [unowned self] in
                        // pass the data image to image View.:)
                        self.itemImage.image = dataImage
                }
                
                
        }
    }

}
