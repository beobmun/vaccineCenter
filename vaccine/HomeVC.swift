//
//  ViewController.swift
//  Covid19VaccinationCenter
//
//  Created by 한법문 on 2021/05/23.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var vaccineCenterBtn: UIButton!
    @IBOutlet weak var referralCenterBtn: UIButton!
    @IBOutlet weak var aroundCenterBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        vaccineCenterBtn.layer.cornerRadius = 10
        referralCenterBtn.layer.cornerRadius = 10
        aroundCenterBtn.layer.cornerRadius = 10
        
        
    }


}

