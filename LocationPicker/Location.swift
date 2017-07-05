//
//  Location.swift
//  LocationPicker
//
//  Created by Almas Sapargali on 7/29/15.
//  Copyright (c) 2015 almassapargali. All rights reserved.
//

import Foundation

import CoreLocation
import Contacts
import AddressBookUI

// class because protocol
public class Location: NSObject {
	public let name: String?
	
	// difference from placemark location is that if location was reverse geocoded,
	// then location point to user selected location
	public let location: CLLocation
	public let placemark: CLPlacemark
	
	public var address: String {
		// try to build full address first
		if let addressDic = placemark.addressDictionary {
			if let lines = addressDic["FormattedAddressLines"] as? [String] {
				return lines.joined(separator: ", ")
			} else {
				// fallback
                guard let postalAddress = CNMutablePostalAddress(placemark: placemark) else { return "" }
                return String.init(CNPostalAddressFormatter().string(from: postalAddress))
			}
		} else {
			return "\(coordinate.latitude), \(coordinate.longitude)"
		}
	}
	
	public init(name: String?, location: CLLocation? = nil, placemark: CLPlacemark) {
		self.name = name
		self.location = location ?? placemark.location!
		self.placemark = placemark
	}
}

extension Optional {
    func then(_ f: (Wrapped) -> Void) {
        if let wrapped = self { f(wrapped) }
    }
}

extension CNMutablePostalAddress {
    convenience init?(placemark: CLPlacemark?) {
        self.init()
        guard let placemark = placemark else { return nil }
        
        placemark.subThoroughfare    .then { street += $0 + " " }
        placemark.thoroughfare       .then { street += $0 }
        placemark.locality           .then { city = $0 }
        placemark.administrativeArea .then { state = $0 }
        placemark.postalCode         .then { postalCode = $0 }
        placemark.country            .then { country = $0 }
        placemark.isoCountryCode     .then { isoCountryCode = $0 }
    }
}

import MapKit

extension Location: MKAnnotation {
    @objc public var coordinate: CLLocationCoordinate2D {
		return location.coordinate
	}
	
    public var title: String? {
		return name ?? address
	}
    
    public var subtitle: String? {
        return name != nil ? address : nil
    }
}
