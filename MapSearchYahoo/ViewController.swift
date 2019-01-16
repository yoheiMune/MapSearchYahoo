//
//  ViewController.swift
//  MapSearch
//
//  Created by Munesada Yohei on 2019/01/16.
//  Copyright © 2019 Munesada Yohei. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import SWXMLHash

class ViewController: UIViewController {

    // UI: マップ表示を行うView（Storyboardと連結）
    @IBOutlet weak var mapView: MKMapView!
    
    // UI: 検索バー（Stoaryboardと連結）
    @IBOutlet weak var searchBar: UISearchBar!

    // 位置情報を取得するマネージャー.
    let locationManager = CLLocationManager()
    
    // 画面がロードされたときに呼び出される.
    override func viewDidLoad() {
        // 親のメソッドを呼び出す（これはお決まりコード）
        super.viewDidLoad()
        
        // マップの delegate を設定します.
        self.mapView.delegate = self
        
        // 検索バーの delegate を設定します.
        self.searchBar.delegate = self
        
        // 位置情報取得処理の delegate を設定します.
        locationManager.delegate = self

        // 現在位置を取得するための権限を、ユーザーにリクエストする.
        // 初めてリクエストする場合には、認可後に「localManager(_, didChangeAuthorization)」が呼び出されます.
        self.locationManager.requestWhenInUseAuthorization()

        // (2回目以降の起動ではこちらが実行されます）
        // ユーザーから利用OKがOKの場合には、
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {

            // Map表示を開始します.
            self.startMapDisplay()
        }
    }
    
    // Map表示を開始します.
    private func startMapDisplay() {
        
        // 10m ごとに取得するように設定します.
        locationManager.distanceFilter = 10
        
        // 位置情報の取得を開始.
        locationManager.startUpdatingLocation()
    }

}

// MARK: CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    
    // ユーザーからの認可/不認可があった場合に呼び出されます.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
                
        // 位置情報取得がOKの場合、
        if status == .authorizedWhenInUse {
            // マップ表示を開始.
            self.startMapDisplay()
        }
    }
    
    // 位置情報を取得する度に、呼び出されます.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 初めて位置情報を取得したら、
        if let location = locations.first {
            
            // 経緯度を取得します.
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            print("latitude: \(lat), longitude: \(lng)")
            
            // 取得した経緯度が中心になるように、Mapの表示を変更します.
            let coords = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)  // 数字が小さいほど、拡大率Up.
            let region = MKCoordinateRegion(center: coords, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
}

// MARK: UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    // 検索バーでユーザーが検索したときに呼び出されます.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        // キーボードを閉じます.
        searchBar.resignFirstResponder()
        
        // ワード指定がなければ終わり.
        guard let searchTerm = searchBar.text else {
            return
        }
        
        // 検索条件を作成します.
        let params = [
            "appid" : API_KEY,
            "query" : searchTerm,
            "lat" : String(format: "%.06f", self.mapView.region.center.latitude),
            "lon" : String(format: "%.06f", self.mapView.region.center.longitude),
            "dist" : "3",  // 周辺3kmを検索
            "results" : "10"  // 最大10件
        ]
                
        // Yahooローカル検索APIのエンドポイント.
        let url = "https://map.yahooapis.jp/search/local/V1/localSearch"
        
        // APIをコール
        Alamofire.request(url, method: .get, parameters: params).responseString { response in
            
            if response.result.isSuccess {
                let xmlString = response.result.value!
                
                let xml = SWXMLHash.parse(xmlString)
                let features = xml["YDF"]["Feature"]
                
                for feature in features.all {
                    if let name = feature["Name"].element?.text,
                        let lonlat = feature["Geometry"]["Coordinates"].element?.text {
                        let arr = lonlat.components(separatedBy: ",")
                        let lon = arr[0]
                        let lat = arr[1]
                        print("name=\(name), lat=\(lat), lon=\(lon)")
                        
                        // マップに追加します.
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(
                            latitude: Double(lat)!,
                            longitude: Double(lon)!)
                        annotation.title = name
                        self.mapView.addAnnotation(annotation)
                    }
                }
            }
        }
    }
}

// MARK: MkMapViewDelete
extension ViewController: MKMapViewDelegate {

    // マップで、アノテーションがタップされた場合に呼び出されます.
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // タイトルを取得して、
        if let title = view.annotation?.title ?? nil {
            // アラートで表示します.
            self.showAlert(message: title)
        }
    }
}
