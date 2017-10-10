//
//  DirectionsViewController.swift
//  pbs
//
//  Created by Ryan Ball on 05/05/2017.
//  Copyright © 2017 Ryan Ball. All rights reserved.
//

import UIKit
import MapKit

class DirectionsViewController: UIViewController , MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let latitude: CLLocationDegrees = 54.647115
        let longitude: CLLocationDegrees = -6.659070
        
        let lanDelta: CLLocationDegrees = 0.05
        
        let lonDelta: CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: lanDelta, longitudeDelta: lonDelta)
        
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = MKCoordinateRegion(center: coordinates, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.title = "Pose Beauty Salon"
        
        annotation.subtitle = "100 Moneyhaw Road"
        
        annotation.coordinate = coordinates
        
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func mapType(_ sender: Any) {
        
        switch ((sender as AnyObject).selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default: // or case 2
            mapView.mapType = .hybrid
        }
    }
    
    @IBAction func getDirections(_ sender: Any) {
        
        let latitude: CLLocationDegrees = 54.647115
        let longitude: CLLocationDegrees = -6.659070
        let url = URL(string: "https://www.posebeautysalon.com")
        
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Pose Beauty Salon"
        mapItem.phoneNumber = "+442886737777"
        mapItem.url = url
        mapItem.openInMaps(launchOptions: options)
        
    }
    
}
