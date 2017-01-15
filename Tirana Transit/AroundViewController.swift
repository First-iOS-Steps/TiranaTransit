//
//  AroundViewController.swift
//  Tirana Transit
//
//  Created by Etjen Ymeraj on 10/7/15.
//  Copyright (c) 2015 Etjen Ymeraj. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AroundViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var stops = Stops()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //user location
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //gps
        
        locationManager.requestWhenInUseAuthorization() //only when we use the app
        locationManager.startUpdatingLocation()
        
        map.showsUserLocation = true
        map.delegate = self
        
        
        //annotation
        let point: CLLocationCoordinate2D = CLLocationCoordinate2DMake(41.327566, 19.818778)
        let title: String = "Station 1"
        let subtitle : String = "Line 1"
        
        let point2: CLLocationCoordinate2D = CLLocationCoordinate2DMake(41.328904, 19.817525)
        let point3: CLLocationCoordinate2D = CLLocationCoordinate2DMake(41.325488, 19.816496)
        let point4: CLLocationCoordinate2D = CLLocationCoordinate2DMake(41.333448, 19.817010)


        
        loadAnnotationsInMap(point, title: title, subtitle: subtitle)
        loadAnnotationsInMap(point2, title: title, subtitle: subtitle)
        loadAnnotationsInMap(point3, title: title, subtitle: subtitle)
        loadAnnotationsInMap(point4, title: title, subtitle: subtitle)


        
        
        
        //long tap gesture 
        
        implementGesture()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func locationManager(_ manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let userLocation: CLLocation = locations[0] as! CLLocation
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        let latDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
        
        
    }
    
    func implementGesture(){
        
        let uilgpr = UILongPressGestureRecognizer(target: self, action: #selector(AroundViewController.action(_:)))
        
        uilgpr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilgpr)
    }
    
    func action(_ gestureRecognizer: UIGestureRecognizer){
        
        let touchPoint = gestureRecognizer.location(in: self.map)
        
        let newCoordinate : CLLocationCoordinate2D = map.convert(touchPoint, toCoordinateFrom: self.map)
        
       loadAnnotationsInMap(newCoordinate, title: "Station 2", subtitle: "Line 2")
        
    }
    
    func loadAnnotationsInMap(_ point: CLLocationCoordinate2D, title: String, subtitle: String){
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = point
        
        annotation.title = title
        annotation.subtitle = subtitle
        
        map.addAnnotation(annotation)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "demo")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "demo")
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        annotationView!.image = UIImage(named: "bus.png")
        
        return annotationView
        
    }

}
