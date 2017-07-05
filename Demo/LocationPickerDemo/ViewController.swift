//
//  ViewController.swift
//  LocationPickerDemo
//
//  Created by Almas Sapargali on 7/29/15.
//  Copyright (c) 2015 almassapargali. All rights reserved.
//

import UIKit
import LocationPicker
import CoreLocation
import MapKit

class ViewController: UIViewController {
	@IBOutlet weak var locationNameLabel: UILabel!
	var location: Location? {
		didSet {
			locationNameLabel.text = location.flatMap({ $0.title }) ?? "No location selected"
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let coordinates = CLLocationCoordinate2D(latitude: 43.25, longitude: 76.95)
		location = Location(name: "Test", location: nil,
			placemark: MKPlacemark(coordinate: coordinates, addressDictionary: [:]))
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "LocationPicker" {
			let locationPicker = segue.destination as! LocationPickerViewController
			locationPicker.location = location
			locationPicker.showCurrentLocationButton = true
			locationPicker.useCurrentLocationAsHint = true
			locationPicker.showCurrentLocationInitially = true
			locationPicker.mapType = .standard
			locationPicker.completion = { self.location = $0 }
		}
	}
}

