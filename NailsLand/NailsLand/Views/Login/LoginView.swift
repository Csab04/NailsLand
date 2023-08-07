//
//  LoginView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @StateObject var authViewModel = AuthViewModel()
    var body: some View {
        NavigationStack{
            ZStack(alignment:.center){
                Color("green").ignoresSafeArea()
                VStack{
                    Image("nailspic")
                         .resizable()
                         .frame(maxWidth: .infinity,maxHeight:350)
                         .ignoresSafeArea()
                    VStack(spacing:20){
                        Text("Sign in with")
                            .font(.title.bold())
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding()
                        
                        EmailTextField(text: $email, imageName: .constant("envelope.fill"), placeHolder: .constant("E-mail"))
                        PasswordTextField(text: $password, imageName: .constant("lock.fill"), placeHolder: .constant("Password"))
                      
                        Button {
                            authViewModel.login(email: email, password: password)
                        } label: {
                            Text("Login in")
                                .frame(width: getRect().width/1.2,height: getRect().width/8)
                                .background(Color(Color.purpleBG))
                                .cornerRadius(.infinity)
                                
                        }
                        
                        HStack{
                            Rectangle()
                                .frame(width: 150,height: 1)
                            Spacer()
                            Text("or")
                            Spacer()
                            Rectangle()
                                .frame(width: 150,height: 1)
                        }
                        .foregroundColor(Color(Color.purpleBG))
                        .padding()
                        
                        Spacer()
                        
                        HStack{
                            Text("Don't have account?")
                            NavigationLink {
                               RegisterView()
                            } label: {
                                Text("Sign up")
                                    .foregroundColor(Color(Color.purpleBG))
                                    .padding()
                            }
                            
                        }
                    } 
                    .frame(width: getRect().width,height: getRect().height/1.55,alignment: .top)
                    .background(Color("gray"))
                   
                    .clipShape(CustomCorner(corner: [.allCorners], radius: 30))
                    
                }
                .foregroundColor(.white)
                .frame(maxHeight: .infinity,alignment: .bottom)
                .ignoresSafeArea()
                .blur(radius: authViewModel.errorLoading ? 30 : 0)
                .overlay {
                    LoadingView(show: $authViewModel.isLoading)
                }
                
                if authViewModel.errorLoading {
                    ErrorAlert(errorMessage: $authViewModel.errorMessage, show: $authViewModel.errorLoading)
                }
                
                
            }
            .navigationBarBackButtonHidden(true)
        }
       
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            LoginView()
            LoginView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(AuthViewModel())
    }
}
