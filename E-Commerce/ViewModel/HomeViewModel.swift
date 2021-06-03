//
//  HomeViewModel.swift
//  E-Commerce
//
//  Created by Fa Ainama Caldera S on 01/03/21.
//

import SwiftUI
import CoreLocation
import Firebase

class HomeViewModel: NSObject,ObservableObject,CLLocationManagerDelegate {
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    @Published var showMenu = false
    
    // Mengambil data dari File item.swift
    @Published var items: [Item] = []
    
    // Ini buat search bar 
    @Published var filtered: [Item] = []
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("autorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            locationManager.requestWhenInUseAuthorization()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        self.userLocation = locations.last
        self.exractLocation()
        self.login()
    }
    
    // Function untuk mengextract lokasi
    func exractLocation(){
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res,err) in
            guard let safeData = res else{return}
            
            var address = ""
            
            address += safeData.first?.name ?? "" //nil colascing
            address += ","
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
    
    // Function login
    func login() {
        Auth.auth().signInAnonymously {(res , err) in
            // Kejadian jika erorr
            if err != nil{
                print(err!.localizedDescription)
                
                return
            }
            
            // Kejadian jika berhasil login
            print("Success = \(res!.user.uid)")
            
            self.fetchData()
        }
    }
    
    // Function memunculkan data dari firebase
    func fetchData() {
        let db = Firestore.firestore()
        
        db.collection("Items").getDocuments {(snap , err) in
            guard let itemData = snap else {return}
            
            self.items = itemData.documents.compactMap( {  (doc) -> Item? in
                
                let id = doc.documentID
                let cost = doc.get("item_cost") as! NSNumber
                let details = doc.get("item_details") as! String
                let image = doc.get("item_image") as! String
                let name = doc.get("item_name") as! String
                let ratings = doc.get("item_ratings") as! String
                
                
                return Item(id: id, item_cost: cost, item_details: details, item_image: image, item_name: name, item_ratings: ratings)
            })
        }
        
    }
    
    // Function search
    func filterData() {
        withAnimation(.linear){
            self.filtered = self.items.filter{
                return $0.item_name.lowercased().contains(self.search.lowercased())
            }
        }
        
    }
    
}
