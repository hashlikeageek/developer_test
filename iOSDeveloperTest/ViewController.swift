//
//  ViewController.swift
//  iOSDeveloperTest
//
//  Created by Ashutosh Kumar Sai on 07/01/17.
//  Copyright © 2017 Ashish Rajendra Kumar Sai. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 19.0760, longitude:73.8777, zoom: 8.0)
        mapView.camera = camera
       // addnewmarker()
        fetchDataFromJSON()
    }
    
    func fetchDataFromJSON()
    {
        if let path = Bundle.main.url(forResource: "data", withExtension: "json") {
            
            do {
                let jsonData = try Data(contentsOf: path, options: .mappedIfSafe)
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary {
                        if let array = jsonResult.value(forKey: "data") as? NSArray {
                            for (_, element) in array.enumerated() {
                                if let element = element as? NSDictionary {
                                    let type = element.value(forKey: "type") as! String
                                    let coordinate = element.value(forKey: "coordinate") as! String
                                    let title = element.value(forKey: "title") as! String
                                    print("type: \(type),  coordinate: \(coordinate), title: \(title)")
                                   
                                    addnewmarker(title: title, coordinate: coordinate, type: type)
                                    
                                }
                            }
                        }
                    }
                } catch let error as NSError {
                    print("Error: \(error)")
                }
            } catch let error as NSError {
                print("Error: \(error)")
            }
        }
    }

  
    func addnewmarker(title: String,coordinate: String, type: String)
    {
        var coordinates = coordinate.characters.split(separator: ",").map(String.init)
      let lat = Double(coordinates[0])
      let long = Double(coordinates[1])
      let position = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
      let marker = GMSMarker(position: position)
      marker.title = "\(title)"
      marker.map = mapView
    }


}

