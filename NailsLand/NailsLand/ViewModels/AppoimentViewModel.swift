//
//  AppoimentViewModel.swift
//  NailsLand
//
//  Created by Csaba Otvos on 23.03.2023.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase
import Collections
import SwiftUI

typealias AppoimentGroup = OrderedDictionary<String,[AppoimentDate]>
class AppoimentViewModel: ObservableObject{
    
    @Published var appoimentDate:[AppoimentDate] = []
    @Published var appoimentDates: AppoimentDate?
    @Published var appoiment:[Appoiment] = []
    @Published var succesAppoiments = false
    @Published var isLoading = false
    @Published var showCalendar =  false
    var db = Firestore.firestore()
    init(){
        fetchAppoimentDate()
        fetchAppoiment()
    }
    
    func fetchAppoimentDate(){
        db.collection("AppoimentTime").order(by: "textTime", descending: true).addSnapshotListener { snapshot, err in
            guard let documents = snapshot?.documents else {
                print("Error the fetch time:\(err!.localizedDescription)")
                return
            }
            
            self.appoimentDate = documents.compactMap{ document -> AppoimentDate? in
                do{
                    return try document.data(as: AppoimentDate.self)
                } catch{
                    print("Error decoding into Appoiment:\(error)")
                    return nil
                }
            }
            
        }
    }
    
    
    func fetchAppoiment(){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        db.collection("Appoiment").order(by: "date", descending: true).whereField("uid", isEqualTo: uid).addSnapshotListener { snapshot, err in
            guard let documents = snapshot?.documents else {
                print("Error the fetch time:\(err!.localizedDescription)")
                return
            }
            
            self.appoiment = documents.compactMap{ document -> Appoiment? in
                do{
                    return try document.data(as: Appoiment.self)
                } catch{
                    print("Error decoding into Appoiment:\(error)")
                    return nil
                }
            }
            
        }
    }
    
   
    
    func addAppoiment(date:Date,time:String,name:[String],email:String,mobileNumber:Int,profileImageURl:String){
        self.isLoading = true
        
        Task{
            do{
                
                guard let uid = Auth.auth().currentUser?.uid else{return}
               
                let appoiment = Appoiment(date: date, time: time, name: name, email: email, mobileNumber: mobileNumber, profileImageUrl: profileImageURl,service: "",price: 0.0,uid: uid)
                
                try! Firestore.firestore().collection("Appoiment").document(uid).setData(from: appoiment){ err in
                    if err == nil {
                        self.succesAppoiments = true
                        self.isLoading = false
                      
                    } else {
                        print("Error\(err!.localizedDescription)")
                    }
                }
            }
          
            
        }
    }
    
    func uploadServiceAndPrice(service:String,price:Double){
        guard let uid = Auth.auth().currentUser?.uid else{return}
       let appoiment = Appoiment(date: Date(), time: "", name: [""], email: "", mobileNumber: 0, profileImageUrl: "", service: service, price: price, uid: uid)
        try! Firestore.firestore().collection("Appoiment").document(uid).setData(from: appoiment){ err in
            if err == nil {
                self.showCalendar = true
                self.isLoading = false
              
            } else {
                print("Error\(err!.localizedDescription)")
            }
        }
    }
    
    
    func deleteAppoimentTime(appoinmentDate:AppoimentDate){
        guard let id = appoinmentDate.id else{return}
            Firestore.firestore().collection("AppoimentTime").document(id).delete()
        
    }
    
    func groupedByMonth() -> AppoimentGroup {
        guard !appoimentDate.isEmpty else {
            return [:]
        }
        let groupedAppoiment = AppoimentGroup(grouping: appoimentDate) { $0.day }
        
        return groupedAppoiment
    }
    
}

