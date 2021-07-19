//
//  VaccineTableVC.swift
//  Covid19VaccinationCenter
//
//  Created by 한법문 on 2021/05/23.
//

import UIKit


class VaccineTableVC: UIViewController {
    
    @IBOutlet weak var tableViewMain: UITableView!
    
    
    var sido: String?
    var sigungu: String?
    var centerData: Array<Any>?
    var arr: [Any] = []
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
        getCenter()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "CenterDetailVC" == id {
            if let controller = segue.destination as? CenterDetailVC {
                if let center = centerData {
                    if let indexPath = tableViewMain.indexPathForSelectedRow {
                        let row = center[indexPath.row]
                        if let r = row as? Dictionary<String, Any> {
                            if let centerName = r["centerName"] as? String {
                                controller.cName = centerName
                            }
                            if let facilityName = r["facilityName"] as? String {
                                controller.fName = facilityName
                            }
                            if let centerType = r["centerType"] as? String {
                                controller.cType = centerType
                            }
                            if let phoneNumber = r["phoneNumber"] as? String {
                                controller.phone = phoneNumber
                            }
                            if let address = r["address"] as? String {
                                controller.addr = address
                            }
                            if let lat = r["lat"] as? String {
                                controller.lat = lat
                            }
                            if let lng = r["lng"] as? String {
                                controller.lng = lng
                            }
                        }
                    }
                    
                }
            }
        }
    }
}



extension VaccineTableVC: UITableViewDelegate, UITableViewDataSource {
    
    // 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let center = centerData {
            return center.count
        } else {
            return 0
        }
    }
    
    // 셀 텍스트
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMain.dequeueReusableCell(withIdentifier: "CenterTableViewCell", for: indexPath) as! CenterTableViewCell
        let idx = indexPath.row
        if let center = centerData {
            let row = center[idx]
            if let r = row as? Dictionary<String, Any> {
                cell.centerName.text = r["centerName"] as! String
                cell.facilityName.text = r["facilityName"] as! String
                cell.address.text = r["address"] as! String
                cell.centerType.text = r["centerType"] as! String
            }
        }
        
        
        return cell
    }
    
    //API 정보 가져오기
    func getCenter() {
        let url = "\(CENTER_API.BASE_URL)/centers?page=1&perPage=263&serviceKey=\(CENTER_API.SERVICE_KEY)"
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let dataJson = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    
                    let d = json["data"] as! Array<Dictionary<String, Any>>
                    for i in d {
                        if i["sido"] as! String == self.sido! {
                            if i["sigungu"] as! String == self.sigungu! {
                                self.arr.append(i)
                            }
                        }
                    }
                    self.centerData = self.arr
                    
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
