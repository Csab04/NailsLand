//
//  RegisterView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    @State var mobileNumber = 0
    @StateObject var authViewModel = AuthViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack(spacing:30){
                    HStack{
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color(Color.purpleBG))
                        }
                        
                        Spacer()
                        
                        Text("Registration")
                        Spacer()
                    }
                    .padding()
                   
                    EmailTextField(text: $firstName, imageName: .constant("person.fill"), placeHolder: .constant("First Name"))
                    EmailTextField(text: $lastName, imageName: .constant("person.fill"), placeHolder: .constant("Last Name"))
                    EmailTextField(text: $email, imageName: .constant("envelope.fill"), placeHolder: .constant("E-mail"))
                    PasswordTextField(text: $password, imageName: .constant("lock.fill"), placeHolder: .constant("Password"))
                    
                    Button {
                        authViewModel.createUser(firstName: firstName, lastName: lastName, mobileNumber: mobileNumber, email: email, password: password)
                    } label: {
                        Text("Sign up")
                            .foregroundColor(.white)
                            .frame(width: getRect().width/1.2,height: getRect().width/8)
                            .background(Color(Color.purpleBG))
                            .cornerRadius(.infinity)
                            .shadow(radius: 15,x: 0,y: 50)
                    }
                    Spacer()
                   
                }
                .blur(radius: authViewModel.errorLoading ? 30 : 0)
                .blur(radius: authViewModel.isLoading ? 30 : 0)
                .overlay(content: {
                    LoadingView(show: $authViewModel.isLoading)
                })
                if authViewModel.errorLoading{
                    ErrorAlert(errorMessage: $authViewModel.errorMessage, show: $authViewModel.errorLoading)
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $authViewModel.showUploadPhotView) {
                UploadPhotoView()
            }
        }
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RegisterView()
            RegisterView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(AuthViewModel())
    }
}
