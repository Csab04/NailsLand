//
//  File.swift
//  NailsLand
//
//  Created by Csaba Otvos on 19.03.2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class AuthViewModel:ObservableObject{
    @Published var errorMessage = ""
    @Published var errorLoading = false
    @Published var succsesLoading = false
    @Published var isLoading = false
    @Published var showUploadPhotView = false
    @AppStorage("log_Status") var logStatus = false
    
    func login(email:String,password:String){
        self.isLoading = true
        Task{
            do{
               try await Auth.auth().signIn(withEmail: email, password: password)
             try await fetchUser()
            }
            catch {
                await MainActor.run(body: {
                    self.errorLoading = true
                    self.errorMessage = error.localizedDescription
                })
                
               
            }
        }
    }
    
    func createUser(firstName:String,lastName:String,mobileNumber:Int,email:String,password:String){
        self.isLoading = true
        Task{
            do{
              try await  Auth.auth().createUser(withEmail: email, password: password)
                guard let uid = Auth.auth().currentUser?.uid else {return}
                let user = User(firstName: firstName, lastName: lastName, email: email, mobileNumber: mobileNumber, password: password, profileImageUrl: "")
                let _ =  try! Firestore.firestore().collection("User").document(uid).setData(from: user){error in
                    if error == nil{
                        self.showUploadPhotView = true
                    }
                }
            } catch{
                try! await Auth.auth().currentUser?.delete()
                await MainActor.run(body: {
                    self.errorLoading = true
                    self.errorMessage = error.localizedDescription
                })
            }
        }
    }
    
    func uploadImage(_ image:UIImage){
        self.isLoading = true
        Task{
            do{
                guard let uid = Auth.auth().currentUser?.uid else {return}
                ImageUploader.uploadImage(image: image) { profileImageUrl in
                    Firestore.firestore().collection("User").document(uid).updateData(["profileImageUrl":profileImageUrl]) { error in
                        if error == nil{
                            print("Saved succesfully photo")
                            self.succsesLoading = true
                            
                        } else {
                            print("Error uplod photo:\(error!.localizedDescription)")
                        }
                        
                    }
                }
            }
            
        }
    }
    
    func fetchUser()async throws{
        guard let userID = Auth.auth().currentUser?.uid else{return}
        let _ = try await Firestore.firestore().collection("User").document(userID).getDocument(as: User.self)
        // MARK: UI Updating Must be Run On Main Thread
        await MainActor.run(body: {
            // Setting UserDefaults data and Changing App's Auth Status
            logStatus = true
        })
    }
    
    func sigOut(){
        Task{
            do{
                try! Auth.auth().signOut()
              
            } 
                await MainActor.run(body: {
                    self.logStatus = false
                })
            
        }
    }
    
}
