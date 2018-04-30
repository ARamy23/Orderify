//
//  RestaurantElementViewController.swift
//  Orderify
//
//  Created by Ahmed Ramy on 4/5/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit
import AnimatableReload
import MapKit

class RestaurantElementViewController: UIViewController
{
    //MARK:- RestaurantElementView Variables
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var ItemsCollectionView: UICollectionView!
    var restaurant: RestaurantElement?
    var image: UIImage?
    var restaurantID: Int? = 0
    var meals = [Meal]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        
    }
    
    func initUI()
    {
        initCollectionView()
        
        if(restaurant != nil)
        {
            restaurantID = restaurant?.id
            let imageURLString = restaurant?.image
//            if imageURLString != nil
//            {
//                convertToUIImage(imageURLString: imageURLString!)
//                {
//                    (image) in
//                    self.restaurantImage.image = image
//                }
//            }
        }
        
        if image != nil
        {
            restaurantImage.image = image
        }
        
    }
    
//func convertToUIImage(imageURLString: String, completion: @escaping (UIImage?)->())
//    {
//        DispatchQueue.global(qos: .userInitiated).async
//            {
//                guard let url:NSURL = NSURL(string : imageURLString) else {print("couldn't use URL"); return;}
//                // It Will turn Into Data
//                guard let imageData : NSData = NSData.init(contentsOf: url as URL) else {print("couldn't convert Item image Data"); return;}
//                // Data Will Encode into Base64
//                let str64 = imageData.base64EncodedData(options: .lineLength64Characters)
//                // Now Base64 will Decode Here
//                let data: NSData = NSData(base64Encoded: str64 , options: .ignoreUnknownCharacters)!
//                // turn  Decoded String into Data
//                let dataImage = UIImage(data: data as Data)
//
//
//                DispatchQueue.main.async
//                {
//                    // pass the data image to image View.:)
//                    completion(dataImage)
//                }
//
//
//        }
//    }
    
    func setModel(model: RestaurantElement)
    {
        restaurant = model
        meals = model.items!
    }
    
    func setImage(image:UIImage?)
    {
        self.image = image
    }
    
    func initCollectionView()
    {
        
        ItemsCollectionView.register(UINib(nibName: "RestaurantElementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantElementCollectionViewCell")
        AnimatableReload.reload(collectionView: self.ItemsCollectionView, animationDirection: "down")
    }
    
    @IBAction func didTapViewOnMapButton(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        let restaurantLocation =  CLLocation(latitude: (restaurant?.lat)!, longitude: (restaurant?.lng)!)
        vc.setLocation(restaurantLocation: restaurantLocation)
        
        navigationController?.pushViewController(vc, animated: true)
                   
    }
    
    
}

extension RestaurantElementViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = ItemsCollectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantElementCollectionViewCell", for: indexPath) as! RestaurantElementCollectionViewCell
        cell.setModel(model: meals[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = ItemsCollectionView.cellForItem(at: indexPath) as! RestaurantElementCollectionViewCell
        let popup = OrderPopupViewController.create(restaurantModel: restaurant!, mealModel: meals[indexPath.row], image: cell.itemImage.image)
        
        
        let sbPopup = SBCardPopupViewController(contentViewController: popup)
        sbPopup.show(onViewController: self)
    }
}



