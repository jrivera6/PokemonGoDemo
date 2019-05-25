//
//  ViewController.swift
//  PokemonGo
//
//  Created by Jhonny Rivera on 5/14/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var ubicacion = CLLocationManager()
    var contActualizaciones = 0
    var pokemons:[Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ubicacion.delegate = self
        pokemons = obtenerPokemons()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            ubicacion.startUpdatingLocation()
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                if let coord = self.ubicacion.location?.coordinate {
                    let pin = MKPointAnnotation()
                    pin.coordinate = coord
                    let randomLat = (Double (arc4random_uniform(200))-100.0) / 5000.0
                    let randomLon = (Double (arc4random_uniform(200))-100.0) / 5000.0
                    pin.coordinate.longitude += randomLon
                    pin.coordinate.latitude += randomLat
                    self.mapView.addAnnotation(pin)
                }
            })
        }else{
            ubicacion.requestWhenInUseAuthorization()
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if contActualizaciones < 1 {
            let region = MKCoordinateRegionMakeWithDistance(ubicacion.location!.coordinate, 1000, 1000)
            mapView.setRegion(region, animated: true)
            contActualizaciones += 1
        }else{
            ubicacion.stopUpdatingLocation()
        }
    }
    
    
    @IBAction func centerTapped(_ sender: Any) {
        
        if let coord = ubicacion.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000)
            mapView.setRegion(region, animated: true)
            contActualizaciones += 1
            print("actualizacion", contActualizaciones)
        }
        
    }
}

