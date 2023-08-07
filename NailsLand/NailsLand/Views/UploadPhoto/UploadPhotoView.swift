//
//  UploadPhotoView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI

struct UploadPhotoView: View {
    @State var image:UIImage?
    @State var showImagePicker = false
    @EnvironmentObject var authViewModel:AuthViewModel
    var body: some View {
        NavigationStack{
            ZStack{
                
                VStack(spacing:40){
                    HStack{
                        Text("Upload Photo")
                            .font(.largeTitle.bold())
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding()
                        Button {
                            
                        } label: {
                            Text("Skip")
                                .foregroundColor(Color(Color.purpleBG))
                                .padding()
                        }
                        
                        
                    }
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        Circle()
                            .stroke(Color(Color.purpleBG),lineWidth: 2)
                            .frame(width: 300)
                            .shadow(color:Color(Color.purpleBG),radius: 10,x: -10,y: 10)
                            .overlay {
                                if let image = image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 300)
                                        .clipShape(Circle())
                                    
                                    
                                } else {
                                    Image(systemName: "person.fill.badge.plus")
                                        .resizable()
                                        .foregroundColor(Color(Color.purpleBG))
                                        .frame(width: 150,height: 150)
                                }
                            }
                    }
                    
                    Button {
                        if let image = image {
                            authViewModel.uploadImage(image)
                        }
                    } label: {
                        Text("Upload photo")
                            .foregroundColor(.white)
                            .frame(width: getRect().width/1.2,height: getRect().height/17)
                            .background(Color(Color.purpleBG))
                            .cornerRadius(.infinity)
                        
                    }
                    .disabled(image == nil)
                    
                    Spacer()
                }
                .overlay(content: {
                    LoadingView(show: $authViewModel.isLoading)
                })
                .blur(radius: authViewModel.succsesLoading ? 30 : 0)
                
                if authViewModel.succsesLoading {
                    SuccsesAlert()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
       
        .fullScreenCover(isPresented: $showImagePicker) {
            ImagePicker(image: $image)
        }
    }
}

struct UploadPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UploadPhotoView()
            UploadPhotoView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(AuthViewModel())
    }
}
