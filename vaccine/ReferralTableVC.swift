//
//  ReferralTableVC.swift
//  Covid19VaccinationCenter
//
//  Created by 한법문 on 2021/05/25.
//

import UIKit


class ReferralTableVC: UIViewController {
    
    @IBOutlet weak var tableViewMain: UITableView!
    
    var addr: String?
    var referralCenterData: Array<Any>?
    var arr: [Any] = []
    var count: Int = 0
    var addrArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
        getReferralCenter()
    }
    
    
    func addrArr() {
        for i in addr! {
            addrArray.append(String(i))
        }
    }
    
    var orgnm: String?
    var orgTlno: String?
    var orgZipaddr: String?
    var sttTm: String?
    var endTm: String?
    var lunchSttTm: String?
    var lunchEndTm: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "ReferralDetailVC" == id {
            if let controller = segue.destination as? ReferralDetailVC {
                if let referral = referralCenterData {
                    if let indexPath = tableViewMain.indexPathForSelectedRow {
                        let row = referral[indexPath.row]
                        if let r = row as? Dictionary<String, Any> {
                            if let orgnm = r["orgnm"] as? String {
                                controller.orgnm = orgnm
                            }
                            if let orgTlno = r["orgTlno"] as? String {
                                controller.orgTlno = orgTlno
                            }
                            if let orgZipaddr = r["orgZipaddr"] as? String {
                                controller.orgZipaddr = orgZipaddr
                            }
                            if let sttTm = r["sttTm"] as? String {
                                controller.sttTm = sttTm
                            }
                            if let endTm = r["endTm"] as? String {
                                controller.endTm = endTm
                            }
                            if let lunchSttTm = r["lunchSttTm"] as? String {
                                controller.lunchSttTm = lunchSttTm
                            }
                            if let lunchEndTm = r["lunchEndTm"] as? String {
                                controller.lunchEndTm = lunchEndTm
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
}



extension ReferralTableVC: UITableViewDelegate, UITableViewDataSource {

    // 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let referral = referralCenterData {
            return referral.count
        } else {
            return 0
        }
    }

    // 셀 텍스트
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMain.dequeueReusableCell(withIdentifier: "ReferralTableViewCell", for: indexPath) as! ReferralTableViewCell
        
        let idx = indexPath.row
        if let referral = referralCenterData {
            let row = referral[idx]
            if let r = row as? Dictionary<String, Any> {
                cell.centerName.text = r["orgnm"] as! String
                cell.address.text = r["orgZipaddr"] as! String
            }
        }
        
        return cell
    }



    //API 정보 가져오기
    func getReferralCenter() {
        addrArr()
        
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
                            for k in 0..<self.addrArray.count {
                                if self.addrArray[k] == aa[k] {
                                    self.count += 1
                                }
                            }
                            if self.count == self.addrArray.count {
                                self.arr.append(i)
                            }
                        }

                    }
                    self.referralCenterData = self.arr
                    
                    DispatchQueue.main.async {
                        self.tableViewMain.reloadData()
                    }
                }
                catch {}
            }
        }
        task.resume()
    }
}
