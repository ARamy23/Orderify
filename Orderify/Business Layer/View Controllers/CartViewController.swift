//
//  CartViewController.swift
//  Orderify
//
//  Created by Ahmed Ramy on 4/27/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit
protocol OrdersDelegate
{
    func add(cartItem: CartItem)
}

class CartViewController: UIViewController, OrdersDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var ordersTableView: UITableView!
    
    //MARK:- Helping Variables

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ordersTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        if ordersTableView.numberOfRows(inSection: 0) < SharedData.sharedInstance.cartItems.count
        {
            ordersTableView.beginUpdates()
            ordersTableView.insertRows(at: [IndexPath(row: SharedData.sharedInstance.cartItems.count - 1, section: 0)], with: UITableViewRowAnimation.automatic)
            ordersTableView.endUpdates()
        }
    }
    
    func add(cartItem: CartItem)
    {
        //TODO:- Setup UI
        SharedData.sharedInstance.cartItems.append(cartItem)
    }

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedData.sharedInstance.cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO:- Setup the Cell
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        cell.setModel(model: SharedData.sharedInstance.cartItems[indexPath.row])
        return cell
    }
    

}
