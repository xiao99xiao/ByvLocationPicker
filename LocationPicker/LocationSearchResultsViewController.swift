//
//  LocationSearchResultsViewController.swift
//  LocationPicker
//
//  Created by Almas Sapargali on 7/29/15.
//  Copyright (c) 2015 almassapargali. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchResultsViewController: UITableViewController {
	var locations: [Location] = []
	var onSelectLocation: ((Location) -> ())?
	var isShowingHistory = false
	var searchHistoryLabel: String?
    var showCurrentLocationSection:Bool = true
    var currentLocationLabel: String?
    var currenLocation: Location? = nil {
        didSet {
            if isShowingHistory && showCurrentLocationSection {
                self.tableView.reloadData()
            }
        }
    }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		extendedLayoutIncludesOpaqueBars = true
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isShowingHistory && (!showCurrentLocationSection || (showCurrentLocationSection && section == 1)) {
            return searchHistoryLabel
        }
        return nil
	}
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isShowingHistory && showCurrentLocationSection {
            return 2
        }
        return 1
    }

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowingHistory && showCurrentLocationSection && section == 0 {
            return 1
        }
        return locations.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell")
			?? UITableViewCell(style: .subtitle, reuseIdentifier: "LocationCell")

        if isShowingHistory && showCurrentLocationSection && indexPath.section == 0 {
            if let currenLocation = currenLocation {
                cell.textLabel?.text = currenLocation.name
                cell.detailTextLabel?.text = currenLocation.address
            }
            let bundle = Bundle(for: LocationPickerViewController.self)
            cell.imageView?.image = UIImage(named: "geolocation", in: bundle, compatibleWith: nil)
            return cell
        }
        cell.imageView?.image = nil
		let location = locations[indexPath.row]
		cell.textLabel?.text = location.name
		cell.detailTextLabel?.text = location.address
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isShowingHistory && showCurrentLocationSection && indexPath.section == 0 {
            if let currenLocation = currenLocation {
                onSelectLocation?(currenLocation)
            }
            return
        }
        onSelectLocation?(locations[indexPath.row])
	}
}
