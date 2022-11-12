//
//  ViewController.swift
//  Map
//
//  Created by Wooyoung on 2022/11/12.
//

import UIKit
import MapKit

// CLLocationManagerDelegate 추가
class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var myMap: MKMapView! // import MapKit
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()   // 지도를 보여주기 위한 변수 추가
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        locationManager.delegate = self // locationManager의 델리게이트를 self로 지정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest   // 정확도 설정
        // 위치 사용 권한 요청을 위해 먼저 info.plist에 "privacy - Location When In Use Usage Description" 추가. value에 메시지 입력.
        locationManager.requestWhenInUseAuthorization() // 위치 데이터 추적을 위해 사용자에게 승인 요청
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
        myMap.showsUserLocation = true  // 위치 보기 값을 true로 설정
        
    }
    
    // 원하는 위도, 경도, 범위로 지도를 보여주는 함수 만들기
    func goLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitude, longitude) // 위도, 경도 값을 매개변수로 좌표 포맷으로 리턴 받음
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span) // 범위 값으로 지도의 크기 리턴 받음
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)    // 중심 위치와 범위로 사각 지형 영역 받음
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    // 원하는 곳에 핀 설치하는 함수 만들기
    func setAnnotation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitude: latitude, longitude: longitude, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    // 위치가 업데이트 되었을 때 지도에 위치를 나타내기 위한 함수 (delegate)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last  // 마지막 위치 값
        // 마지막 위치 값으로 goLocation 함수 호출. 범위값은 작을 수록 확대되는 효과가 있음.
        _ = goLocation(latitude: (pLocation?.coordinate.latitude)!, longitude: (pLocation?.coordinate.longitude)!, delta: 0.01)
        // 위도, 경도 값을 가지고 역으로 주소를 찾기.
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first  //
            let country = pm!.country   // 나라 값
            var address: String = country! // address에 나라 추가
            if pm!.locality != nil {
                // pm에 지역 값이 존재한다면
                address += " "
                address += pm!.locality!    // address에 지역 값 추가
            }
            if pm!.thoroughfare != nil {
                // pm에 도로 주소가 없다면
                address += " "
                address += pm!.thoroughfare!    // address에 도로 주소 추가
            }
            self.lblLocationInfo1.text = "현재 위치"
            self.lblLocationInfo2.text = address
        })
        locationManager.stopUpdatingLocation()  // 위치가 업데이트 되는 것을 멈추게 함.
    }

    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        // 세그먼트 컨트롤의 각 버튼을 누를 때, 각각 위치의 핀 설치하기
        if sender.selectedSegmentIndex == 0 {
            self.lblLocationInfo1.text = ""
            self.lblLocationInfo2.text = ""
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 {
            setAnnotation(latitude: 37.751853, longitude: 128.87605740000004, delta: 1, title: "한국폴리텍대학 강릉캠퍼스", subtitle: "강원도 강릉시 남산초교길 121")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "한국폴리텍대학 강릉캠퍼스"
        } else if sender.selectedSegmentIndex == 2 {
            setAnnotation(latitude: 37.556876, longitude: 126.914066, delta: 0.1, title: "이지스퍼블리싱", subtitle: "서울시 마포구 잔다리로 109 이지스 빌딩")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "이지스퍼블리싱 출판사"
        }
    }
}

