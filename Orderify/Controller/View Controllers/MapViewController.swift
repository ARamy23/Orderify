//
//  MapViewController.swift
//  Orderify
//
//  Created by Ahmed Ramy on 4/27/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var restaurantMapView: MKMapView!
    
    //MARK:- Helping Variables
    var restaurantLocation: CLLocation?
    let regionRadius: CLLocationDistance = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupMap()
        
    }
    
    func setLocation(restaurantLocation: CLLocation)
    {
        self.restaurantLocation = restaurantLocation
    }
    
    func setupMap()
    {
        if restaurantLocation != nil
        {
            //TODO:- Setup map here
            if restaurantLocation != nil
            {centerMapOnLocation(location: restaurantLocation!)}
            else{ return }
        }
    }
    
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        restaurantMapView.setRegion(coordinateRegion, animated: true)
    }

}

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
