//
//  CenterTableViewCell.swift
//  Covid19VaccinationCenter
//
//  Created by 한법문 on 2021/05/23.
//

import UIKit


class CenterTableViewCell: UITableViewCell {
    @IBOutlet weak var centerName: UILabel!
    @IBOutlet weak var facilityName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var centerType: UILabel!
}


class ReferralTableViewCell: UITableViewCell {
    
    @IBOutlet weak var centerName: UILabel!
    @IBOutlet weak var address: UILabel!
}
