//
//  ReferralDetailVC.swift
//  Covid19VaccinationCenter
//
//  Created by 한법문 on 2021/05/25.
//

import UIKit
import CoreLocation
import MapKit


class ReferralDetailVC: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var business: UILabel!
    @IBOutlet weak var lunch: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    var orgnm: String?
    var orgTlno: String?
    var orgZipaddr: String?
    var sttTm: String?
    var endTm: String?
    var lunchSttTm: String?
    var lunchEndTm: String?
    
    var lunchTime: String?
    var businessTime: String?
    
    var addrLat: Double?
    var addrLng: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = orgnm!
        number.text = "📞 \(orgTlno!)"
        address.text = orgZipaddr!
        lunchT()
        businessT()
        
        mapView.delegate = self
        
        getCoordinatesFromPlace(place: orgZipaddr!)
        
        if let lat = addrLat {
            if let lng = addrLng {
                let mark = Marker(title: orgnm, subtitle: nil, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng))
                mapView.addAnnotation(mark)
                locationAround(latitude: lat, longitude: lng, delta: 0.004)
            }
        }
        
    }
    
    func lunchT() {
        if let st = lunchSttTm {
            var s: String = ""
            for i in st {
                s += String(i)
                if s.count == 2 {
                    s += ":"
                }
            }
            if let et = lunchEndTm {
                var e: String = ""
                for i in et {
                    e += String(i)
                    if e.count == 2 {
                        e += ":"
                    }
                }
                lunch.text = "점심 시간 : \(s) ~ \(e)"
            }
        }
    }
    
    func businessT() {
        if let st = sttTm {
            var s: String = ""
            for i in st {
                s += String(i)
                if s.count == 2 {
                    s += ":"
                }
            }
            if let et = endTm {
                var e: String = ""
                for i in et {
                    e += String(i)
                    if e.count == 2 {
                        e += ":"
                    }
                }
                business.text = "영업 시간 : \(s) ~ \(e)"
            }
        }
    }
}

extension ReferralDetailVC: MKMapViewDelegate {
    
    //주소로 위도 경도 가져오기
    func getCoordinatesFromPlace(place: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(place) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location?.coordinate
            else {
                return
            }
            self.addrLat = location.latitude
            self.addrLng = location.longitude
            
            // 지도 마크 표시
            if let lat = self.addrLat {
                if let lng = self.addrLng {
                    let mark = Marker(title: self.orgnm, subtitle: nil, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng))
                    self.mapView.addAnnotation(mark)
                    self.locationAround(latitude: lat, longitude: lng, delta: 0.003)
                }
            }
        }
    }
    
    // 마크 주위만 지도에 표시
    func locationAround(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta: Double) {
        let coordinateLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        mapView.setRegion(locationRegion, animated: true)
    }
    
}
