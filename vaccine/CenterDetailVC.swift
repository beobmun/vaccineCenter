//
//  CenterDetailVC.swift
//  Covid19VaccinationCenter
//
//  Created by νλ²λ¬Έ on 2021/05/24.
//

import UIKit
import MapKit


class CenterDetailVC: UIViewController {
    
    @IBOutlet weak var centerName: UILabel!
    @IBOutlet weak var facilityName: UILabel!
    @IBOutlet weak var centerType: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    
    var cName: String?
    var fName: String?
    var cType: String?
    var phone: String?
    var addr: String?
    var lat: String?
    var lng: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerName.text = cName!
        facilityName.text = fName!
        centerType.text = cType!
        phoneNumber.text = "π \(phone!)"
        address.text = addr!
        
        mapView.delegate = self
        
        // μ§λμ λ§ν¬ νμ
        let mark = Marker(title: cName, subtitle: fName, coordinate: CLLocationCoordinate2D(latitude: Double(lat!)!, longitude: Double(lng!)!))
        mapView.addAnnotation(mark)
        locationAround(latitude: Double(lat!)!, longitude: Double(lng!)!, delta: 0.004)

    }
}

extension CenterDetailVC: MKMapViewDelegate {
    
    // λ§ν¬ μ£Όμλ§ μ§λμ νμ
    func locationAround(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta: Double) {
        let coordinateLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        mapView.setRegion(locationRegion, animated: true)
    }
    
}
