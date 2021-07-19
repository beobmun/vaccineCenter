//
//  BookingWebVC.swift
//  Covid19VaccinationCenter
//
//  Created by 한법문 on 2021/05/26.
//

import UIKit
import WebKit

class BookingWebVC: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    let url = URL(string: "https://ncvr.kdca.go.kr/cobk/index.html")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.load(URLRequest(url: url!))
    }
}
