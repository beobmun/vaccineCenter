//
//  referralCenterSerchVC.swift
//  Covid19VaccinationCenter
//
//  Created by 한법문 on 2021/05/25.
//

import UIKit


class ReferralCenterSearchVC: UIViewController {
    
    @IBOutlet weak var sidoTextField: UITextField!
    @IBOutlet weak var sigunguTextField: UITextField!
    
    var sidoPickerView = UIPickerView()
    var sigunguPickerView = UIPickerView()
    
    
    @IBAction func inquiryBtnClicked(_ sender: UIButton) {
        if sidoTextField.text == ""{
            self.view.makeToast("광역시도를 선택해주세요", duration: 1.0, position: .center)
        } else if sigunguTextField.text == "" {
            self.view.makeToast("시군구를 선택해주세요", duration: 1.0, position: .center)
        } else {
            self.performSegue(withIdentifier: "ReferralTableVC", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //PickerView delegate 설정
        sidoTextField.delegate = self
        sidoPickerView.delegate = self
        sidoPickerView.dataSource = self
        sidoTextField.inputView = sidoPickerView
        sidoTextField.tintColor = .clear
        sigunguTextField.delegate = self
        sigunguPickerView.delegate = self
        sigunguPickerView.dataSource = self
        sigunguTextField.inputView = sigunguPickerView
        sigunguTextField.tintColor = .clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "ReferralTableVC"  == id {
            if let controller = segue.destination as? ReferralTableVC {
                if self.sidoTextField.text! == "세종특별자치시" {
                    controller.addr = "\(self.sidoTextField.text!)"
                } else {
                    controller.addr = "\(self.sidoTextField.text!) \(self.sigunguTextField.text!)"
                }
            }
        }
    }
}



extension ReferralCenterSearchVC: UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // PickerView 설정
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sidoPickerView {
            return LOCALS.sido.count
        } else {
            if sidoTextField.text == "서울특별시" {
                return LOCALS.seoul.count
            } else if sidoTextField.text == "부산광역시" {
                return LOCALS.busan.count
            } else if sidoTextField.text == "대구광역시" {
                return LOCALS.daegu.count
            } else if sidoTextField.text == "인천광역시" {
                return LOCALS.incheon.count
            } else if sidoTextField.text == "광주광역시" {
                return LOCALS.gwangju.count
            } else if sidoTextField.text == "대전광역시" {
                return LOCALS.daejeon.count
            } else if sidoTextField.text == "울산광역시" {
                return LOCALS.ulsan.count
            } else if sidoTextField.text == "세종특별자치시" {
                return LOCALS.sejong.count
            } else if sidoTextField.text == "경기도" {
                return LOCALS.gyeonggi.count
            } else if sidoTextField.text == "강원도" {
                return LOCALS.gangwon.count
            } else if sidoTextField.text == "충청북도" {
                return LOCALS.chungcheongN.count
            } else if sidoTextField.text == "충청남도" {
                return LOCALS.chungcheongS.count
            } else if sidoTextField.text == "전라북도" {
                return LOCALS.jeollaN.count
            } else if sidoTextField.text == "전라남도" {
                return LOCALS.jeonllaS.count
            } else if sidoTextField.text == "경상북도" {
                return LOCALS.gyeongsangN.count
            } else if sidoTextField.text == "경상남도" {
                return LOCALS.gyeongsangS.count
            } else if sidoTextField.text == "제주특별자치도" {
                return LOCALS.jeju.count
            } else {
                return LOCALS.non.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sidoPickerView {
            return LOCALS.sido[row]
        } else {
            if sidoTextField.text == "서울특별시" {
                return LOCALS.seoul[row]
            } else if sidoTextField.text == "부산광역시" {
                return LOCALS.busan[row]
            } else if sidoTextField.text == "대구광역시" {
                return LOCALS.daegu[row]
            } else if sidoTextField.text == "인천광역시" {
                return LOCALS.incheon[row]
            } else if sidoTextField.text == "광주광역시" {
                return LOCALS.gwangju[row]
            } else if sidoTextField.text == "대전광역시" {
                return LOCALS.daejeon[row]
            } else if sidoTextField.text == "울산광역시" {
                return LOCALS.ulsan[row]
            } else if sidoTextField.text == "세종특별자치시" {
                return LOCALS.sejong[row]
            } else if sidoTextField.text == "경기도" {
                return LOCALS.gyeonggi[row]
            } else if sidoTextField.text == "강원도" {
                return LOCALS.gangwon[row]
            } else if sidoTextField.text == "충청북도" {
                return LOCALS.chungcheongN[row]
            } else if sidoTextField.text == "충청남도" {
                return LOCALS.chungcheongS[row]
            } else if sidoTextField.text == "전라북도" {
                return LOCALS.jeollaN[row]
            } else if sidoTextField.text == "전라남도" {
                return LOCALS.jeonllaS[row]
            } else if sidoTextField.text == "경상북도" {
                return LOCALS.gyeongsangN[row]
            } else if sidoTextField.text == "경상남도" {
                return LOCALS.gyeongsangS[row]
            } else if sidoTextField.text == "제주특별자치도" {
                return LOCALS.jeju[row]
            } else {
                return LOCALS.non[row]
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sidoPickerView {
            sidoTextField.text = LOCALS.sido[row]
            sidoTextField.resignFirstResponder()
        } else {
            if sidoTextField.text == "서울특별시" {
                sigunguTextField.text = LOCALS.seoul[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "부산광역시" {
                sigunguTextField.text = LOCALS.busan[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "대구광역시" {
                sigunguTextField.text = LOCALS.daegu[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "인천광역시" {
                sigunguTextField.text = LOCALS.incheon[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "광주광역시" {
                sigunguTextField.text = LOCALS.gwangju[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "대전광역시" {
                sigunguTextField.text = LOCALS.daejeon[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "울산광역시" {
                sigunguTextField.text = LOCALS.ulsan[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "세종특별자치시" {
                sigunguTextField.text = LOCALS.sejong[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "경기도" {
                sigunguTextField.text = LOCALS.gyeonggi[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "강원도" {
                sigunguTextField.text = LOCALS.gangwon[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "충청북도" {
                sigunguTextField.text = LOCALS.chungcheongN[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "충청남도" {
                sigunguTextField.text = LOCALS.chungcheongS[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "전라북도" {
                sigunguTextField.text = LOCALS.jeollaN[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "전라남도" {
                sigunguTextField.text = LOCALS.jeonllaS[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "경상북도" {
                sigunguTextField.text = LOCALS.gyeongsangN[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "경상남도" {
                sigunguTextField.text = LOCALS.gyeongsangS[row]
                sigunguTextField.resignFirstResponder()
            } else if sidoTextField.text == "제주특별자치도" {
                sigunguTextField.text = LOCALS.jeju[row]
                sigunguTextField.resignFirstResponder()
            }
        }
    }
}
