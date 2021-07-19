//
//  constants.swift
//  vaccine
//
//  Created by 한법문 on 2021/05/29.
//

import Foundation
import MapKit

enum LOCALS {
     // 지역 상수 설정
    static let sido = ["서울특별시", "부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시", "세종특별자치시", "경기도", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주특별자치도"]
    static let seoul = ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]
    static let busan = ["강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"]
    static let daegu = ["남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구"]
    static let incheon = ["강화군", "계양구", "남동구", "동구", "미추홀구", "부평구", "서구", "연수구", "옹진군", "중구"]
    static let gwangju = ["광산구", "남구", "동구", "북구", "서구"]
    static let daejeon = ["대덕구", "동구", "서구", "유성구", "중구"]
    static let ulsan = ["남구", "동구", "북구", "울주군", "중구"]
    static let sejong = ["세종시"]
    static let gyeonggi = ["가평군", "고양시 덕양구", "고양시 일산동구", "고양시 일산서구", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시 분당구", "성남시 수정구", "성남시 중원구", "수원시 권선구", "수원시 영통구", "수원시 장안구", "수원시 팔달구", "시흥시", "안산시 단원구", "안산시 상록구", "안성시", "안양시 동안구", "안양시 만안구", "양주시", "양평군", "여주시", "연천군", "오산시", "용인시 기흥구", "용인시 수지구", "용인시 처인구", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"]
    static let gangwon = ["강릉시", "고성군", "동해시", "삼척시", "속초시", "양구군", "양양군", "영월군", "원주시", "인제군", "정선군", "철원군", "춘천시", "태백시", "평창군", "홍천군", "화천군", "횡성군"]
    static let chungcheongN = ["괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "제천시", "증평군", "진천군", "청주시 상당구", "청주시 서원구", "청주시 청원구", "청주시 흥덕구", "충주시"]
    static let chungcheongS = ["계룡시", "공주시", "금산군", "논산시", "당진시", "보령시", "부여군", "서산시", "서천군", "아산시", "예산군", "천안시", "청양군", "태안군", "홍성군"]
    static let jeollaN = ["고창군", "군산시", "김제시", "남원시", "무주군", "부안군", "순창군", "완주군", "익산시", "임실군", "장수군", "전주시", "정읍시", "진안군"]
    static let jeonllaS = ["강진군", "고흥군", "곡성군", "광양시", "구례군", "나주시", "담양군", "목포시", "무안군", "보성군", "순천시", "신안군", "여수시", "영광군", "영암군", "완도군", "장성군", "장흥군", "진도군", "함평군", "해남군", "화순군"]
    static let gyeongsangN = ["경산시", "경주시", "고령군", "구미시", "군위군", "김천시", "문경시", "봉화군", "상주시", "성주군", "안동시", "영덕군", "영양군", "영주시", "영천시", "예천군", "울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군", "포항시 남구", "포항시 북구"]
    static let gyeongsangS = ["거제시", "거창군", "고성군", "김해시", "남해군", "밀양시", "사천시", "산청군", "양산시", "의령군", "진주시", "창녕군", "창원시", "통영시", "하동군", "함안군", "함양군", "합천군"]
    static let jeju = ["서귀포시", "제주시"]
    static let non = ["광역시군을 먼저 선택해주세요"]
}

enum CENTER_API {
    static let BASE_URL: String = "https://api.odcloud.kr/api/15077586/v1"
    static let SERVICE_KEY: String = "LhgTKfRfM3ttAo8YnPLNWIiv7HNj6MKDGDD2hM%2Bo8eFs5Dc1GoBVTCxId9CZE1vODiOYeuH%2FqaCEmpi2cC1Ayg%3D%3D"
}

enum REFERRAL_API {
    static let BASE_URL: String = "https://api.odcloud.kr/api/apnmOrg/v1"
    static let SERVICE_KEY: String = "LhgTKfRfM3ttAo8YnPLNWIiv7HNj6MKDGDD2hM%2Bo8eFs5Dc1GoBVTCxId9CZE1vODiOYeuH%2FqaCEmpi2cC1Ayg%3D%3D"
}


class Marker: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let subtitle: String?
    
    init (title: String?,
          subtitle: String?,
          coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}
