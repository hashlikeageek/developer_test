//
//  ViewController.swift
//  iOSDeveloperTest
//
//  Created by Ashutosh Kumar Sai on 07/01/17.
//  Copyright © 2017 Ashish Rajendra Kumar Sai. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var picker: UIPickerView!
    
    var passingCordinates: CLLocationCoordinate2D!
    var marker : GMSMarker!
    
    @IBAction func filterClicked(_ sender: Any) {
        filter(input: model.sharedInstance().myArr as NSArray)
    }
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.picker.delegate = self
        self.picker.dataSource = self
        mapView.delegate = self
        
         pickerData = ["All", "Normal Events", "People", "Exclusive Events"]
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 19.0760, longitude:73.8777, zoom: 8.0)
        mapView.camera = camera
       // addnewmarker()
        fetchDataFromJSON()
        
        print(model.sharedInstance().myArr)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func filter (input: NSArray)
    {
        let row = picker.selectedRow(inComponent: 0)
        print(row)
        
        switch row
        {
        case 0 :  parsearry(input: input)
        case 1 : NormalEvents_filter(input: input)
        case 2 : People_filter(input: input)
        case 3 : exclusive_filter(input: input)
        default: print("default executed")
        }
        
        }
   
    
    
    func fetchDataFromJSON()
    {
        if let path = Bundle.main.url(forResource: "data", withExtension: "json") {
            
            do {
                let jsonData = try Data(contentsOf: path, options: .mappedIfSafe)
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary {
                        if let jsonarray = jsonResult.value(forKey: "data") as? NSArray {
                            parsearry(input: jsonarray)
                            model.sharedInstance().myArr = jsonarray as [AnyObject]
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
      passingCordinates = position
      marker = GMSMarker(position: position)
      marker.title = "\(title)"
      marker.map = mapView
    }
    
    
    func parsearry(input: NSArray)
    {
        for (_, element) in input.enumerated() {
            if let element = element as? NSDictionary {
                let type = element.value(forKey: "type") as! String
                let coordinate = element.value(forKey: "coordinate") as! String
                let title = element.value(forKey: "title") as! String
                print("type: \(type),  coordinate: \(coordinate), title: \(title)")
                
                
                addnewmarker(title: title, coordinate: coordinate, type: type)
                
            }
        }
    }
    
    func exclusive_filter (input: NSArray)
    {
        mapView.clear()
        
        for (_, element) in input.enumerated() {
            if let element = element as? NSDictionary {
                let type = element.value(forKey: "type") as! String
                let coordinate = element.value(forKey: "coordinate") as! String
                let title = element.value(forKey: "title") as! String
                print("type: \(type),  coordinate: \(coordinate), title: \(title)")
                if type == "ex"
                {
                  addnewmarker(title: title, coordinate: coordinate, type: type)
                }
                else
                {
                    print ("Error in exclusive filter")
                }
                
            }
        }

    }
    
    func NormalEvents_filter (input: NSArray)
    {
        mapView.clear()
        
        for (_, element) in input.enumerated() {
            if let element = element as? NSDictionary {
                let type = element.value(forKey: "type") as! String
                let coordinate = element.value(forKey: "coordinate") as! String
                let title = element.value(forKey: "title") as! String
                print("type: \(type),  coordinate: \(coordinate), title: \(title)")
                if type == "ev"
                {
                    addnewmarker(title: title, coordinate: coordinate, type: type)
                }
                else
                {
                    print ("Error")
                }
                
            }
        }
        
    }
    
    func People_filter (input: NSArray)
    {
        mapView.clear()
        
        for (_, element) in input.enumerated() {
            if let element = element as? NSDictionary {
                let type = element.value(forKey: "type") as! String
                let coordinate = element.value(forKey: "coordinate") as! String
                let title = element.value(forKey: "title") as! String
                print("type: \(type),  coordinate: \(coordinate), title: \(title)")
                if type == "pe"
                {
                    addnewmarker(title: title, coordinate: coordinate, type: type)
                }
                else
                {
                    print ("Error")
                }
                
            }
        }
        
    }
    
     func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
     
        performSegue(withIdentifier: "detail", sender: self)
    }

    


}

