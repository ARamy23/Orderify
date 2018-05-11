//
//  RestaurantViewController.swift
//  Orderify
//
//  Created by Ahmed Ramy on 4/3/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit
import SVProgressHUD
import TableViewReloadAnimation

class RestaurantViewController: BaseViewController
{

    @IBOutlet weak var restaurantTableView: UITableView!
    
    var restaurants = [RestaurantElement]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        initTableView()
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        loadData()
    }
    
    func initTableView()
    {
        
        restaurantTableView.register(UINib(nibName: "RestaurantTableViewCell", bundle: nil), forCellReuseIdentifier: "RestaurantTableViewCell")
        loadData()
    }
    
    
    
    
    func loadData()
    {
        SVProgressHUD.showInfo(withStatus: "Fetching Data")
        APIManager().getRestaurants { (restaurants) in
            DispatchQueue.global(qos: .userInitiated).async
            { [unowned self] in
                if restaurants != nil
                {
                    self.restaurants = restaurants!.restaurants!
                    DispatchQueue.main.async{ [unowned self] in
                        self.restaurantTableView.reloadData(
                    with: .simple(duration: 0.75, direction: .rotation3D(type: .spiderMan),
                                  constantDelay: 0))
                        SVProgressHUD.dismiss()}
                }
                else
                {
                    DispatchQueue.main.async{ [unowned self] in
                        SVProgressHUD.showError(withStatus: "Couldn't load data, perhaps the connection is not strong enough?")
                    }
                }
            }
        }
        
    }
    
    
}

extension RestaurantViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = restaurantTableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        cell.setModel(model: restaurants[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetViewController = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantElementViewController") as! RestaurantElementViewController
        targetViewController.setModel(model: restaurants[indexPath.row])
        let cell = restaurantTableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
        targetViewController.setImage(image: cell.restaurantImage.image)
        self.navigationController?.pushViewController(targetViewController, animated: true)
    }
    
}
