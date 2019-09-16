//
//  ViewController.swift
//  MapKitTest02
//
//  Created by D7703_16 on 2019. 9. 16..
//  Copyright © 2019년 201526109. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // DIT 위도 경도 설정.
        let location = CLLocationCoordinate2D(latitude: 35.165005, longitude: 129.071484)
        
        //반경 설정
        //let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center : location, latitudinalMeters : 300, longitudinalMeters: 300)
        
        //regin 설정
        //let region = MKCoordinateRegion(center: location, span: span)
        
        //mapView에 add
        mapView.setRegion(region, animated: true)
    }
    
    

}

