//
//  AroundCenterVC.swift
//  Covid19VaccinationCenter
//
//  Created by 한법문 on 2021/05/25.
//

import UIKit
import MapKit
import CoreLocation

class AroundCenterVC: UIViewController {
    
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var mapView: MKMapView!
    
    var locationManager: CLLocationManager?
    
    var myLat: Double?
    var myLng: Double?
    var delta: Double = 0.05
    var count: Int = 0
    var myLocal: [String] = []
    var referralLat: Double?
    var referralLng: Double?
    var orgnm: String = ""
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        getCenter()
        
        
    }
    @IBAction func touchSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            removeAllAnnotations()
            self.delta = 0.05
            if let lat = self.myLat {
                if let lng = self.myLng {
                    locationAround(latitude: lat, longitude: lng, delta: self.delta)
                }
            }
            getCenter()
        default:
            removeAllAnnotations()
            self.delta = 0.01
            if let lat = self.myLat {
                if let lng = self.myLng {
                    locationAround(latitude: lat, longitude: lng, delta: self.delta)
                    findLocation(latitude: lat, longitude: lng)

                }
            }

        }
    }
    
    
}


extension AroundCenterVC: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.myLat = location.coordinate.latitude
            self.myLng = location.coordinate.longitude
        }
        
        if let lat = self.myLat {
            if let lng = self.myLng {
                locationAround(latitude: lat, longitude: lng, delta: self.delta)
            }
        }
    }
    
    //주위만 지도에 표시
    func locationAround(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta: Double) {
        let coordinateLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        mapView.setRegion(locationRegion, animated: true)
    }
    
    // 현재위치 좌표로 주소가져오기
    func findLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let findLocation = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { (placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                if let administrativeArea: String = address.last?.administrativeArea {
                    self.myLocal.removeAll()
                    for i in administrativeArea {
                        self.myLocal.append(String(i))
                    }
                    
                    //위탁의료기관 정보
                    self.getReferralCenter()
                }
            }
        }
    }
    
    //주소로 위도 경도 가져오기
    func getCoordinatesFromPlace(place: String, centerName: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(place) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location?.coordinate
            else {
                return
            }
            self.referralLat = location.latitude
            self.referralLng = location.longitude
            
            // 지도 마크 표시
            let mark = Marker(title: centerName, subtitle: nil, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
            self.mapView.addAnnotation(mark)
        }
    }
    
    //예방접종센터 정보 가져오기
    func getCenter() {
        let url = "\(CENTER_API.BASE_URL)/centers?page=1&perPage=263&serviceKey=\(CENTER_API.SERVICE_KEY)"
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let dataJson = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    
                    let d = json["data"] as! Array<Dictionary<String, Any>>

                    for i in d {
                        let lat: Double = Double(i["lat"] as! String)!
                        let lng: Double = Double(i["lng"] as! String)!
                        let n = i["centerName"] as! String
                        let f = i["facilityName"] as! String
                        let mark = Marker(title: n, subtitle: f, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng))
                        self.mapView.addAnnotation(mark)
                    }
                    
                }
                catch {}
            }
        }
        task.resume()
    }
    
    
    
    //위탁의료기관 정보 가져오기
    func getReferralCenter() {
        
        let url = "\(REFERRAL_API.BASE_URL)/list?page=1&perPage=13028&serviceKey=\(REFERRAL_API.SERVICE_KEY)"
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let dataJson = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>

                    let d = json["data"] as! Array<Dictionary<String, Any>>
                    for i in d {
                        var aa: [String] = []
                        self.count = 0
                        if let a = i["orgZipaddr"] as? String {
                            for j in a {
                                aa.append(String(j))
                            }
                            for k in 0..<self.myLocal.count {
                                if self.myLocal[k] == aa[k] {
                                    self.count += 1
                                }
                            }
                            if self.count == self.myLocal.count {
                                let n = i["orgnm"] as! String
                                self.getCoordinatesFromPlace(place: a, centerName: n)
                            }
                        }


                        
                    }
                }
                catch {}
            }
        }
        task.resume()
    
    }
    
    // mark 지우기
    func removeAllAnnotations() {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
    }
}
