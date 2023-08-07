//
//  AccountView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 19.04.2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct AccountView: View {
    var  user:User?
    var body: some View {
        VStack(spacing:30){
            HStack{
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Save")
                }
                

            }
            .padding()
            if let user = user{
                AccountRow(user: user)
            }
          
           
            Spacer()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}


struct AccountRow:View{
    var user:User
    var body: some View{
        VStack{
            WebImage(url: URL(string: user.profileImageUrl)).placeholder{
                Circle()
                    .overlay {
                        Image(systemName: "person.fill")
                            .resizable()
                            .foregroundColor(Color(Color.purpleBG))
                    }
            }
                .resizable()
                .frame(width: 185,height: 180)
                .aspectRatio( contentMode: .fill)
                .clipShape(Circle())
                .padding(.top,34)
                
            ScrollView{
                
            }
        
        }
    }
}
