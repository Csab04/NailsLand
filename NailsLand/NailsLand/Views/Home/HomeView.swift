//
//  HomeView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
struct HomeView: View {
    @StateObject var appoimentViewModel = AppoimentViewModel()
    @State var user: User?
   @State var showCalendar = false
    var body: some View {
        NavigationStack{
            ZStack(alignment:.top){
                Color.black.ignoresSafeArea()
                
                
                VStack{
                    
                    
                    ScrollView{
                        VStack(alignment:.leading,spacing: 20){
                             
                            
                             
                            
                            Button {
                                showCalendar.toggle()
                            } label: {
                                Text("Book now")
                                    .foregroundColor(.white)
                                    .frame(width: 250,height: 50)
                                    .border(Color(Color.purpleBG),width: 2)
                                    
                            }
                            .toolbar(.hidden, for: .tabBar)
                            
                           
                            Text("New prodcut")
                                .font(.title2.bold())
                            
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(products){product in
                                        NavigationLink {
                                            ProductView(product: product)
                                        } label: {
                                            ProductCard(product: product)
                                        }

                                        
                                    }
                                }
                            }
                            Text("Sales")
                                .font(.title2.bold())
                            ScrollView(.horizontal){
                               
                            }
                            
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding()
                    }
                    .safeAreaInset(edge: .top) {
                        if let user = user {
                            HomeTitleRow(user: User(firstName: user.firstName, lastName: user.lastName, email: user.email, mobileNumber: user.mobileNumber, password: user.password, profileImageUrl: user.profileImageUrl) )
                                .background(LinearGradient(colors: [.teal.opacity(0.5),.blue.opacity(0.5),.red.opacity(0.5),.pink.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .shadow(radius: 10,y: 150)
                                .clipShape(CustomCorner(corner: [.allCorners], radius: 20))
                                .edgesIgnoringSafeArea(.all)
                            
                        }
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                

            }
            .navigationBarBackButtonHidden(true) 
            .task {
                if user != nil {return}
                await fetchUser()
                
            }
            .fullScreenCover(isPresented: $showCalendar) {
                ServiceView()
            }
        }
       
    }
       
    
    func fetchUser()async{
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard  let users = try? await Firestore.firestore().collection("User").document(uid).getDocument(as: User.self) else {
            return
        }
        await MainActor.run(body: {
            user = users
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        HomeView()
            .preferredColorScheme(.dark)
    }
}
