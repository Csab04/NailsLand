//
//  HomeTitleRow.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct HomeTitleRow: View {
    var user:User
    var body: some View {
        HStack{
            WebImage(url: URL(string: user.profileImageUrl)).placeholder{
                Circle()
                    .overlay {
                        Image(systemName: "person.fill")
                            .foregroundColor(Color(Color.purpleBG))
                    }
            }
                .resizable()
                .frame(width: 75,height: 75)
                .aspectRatio( contentMode: .fill)
                .clipShape(Circle())
                .padding(.top,34)
            VStack(alignment:.leading){
                Text("Welcome \(user.firstName)!")
                    .font(.title2.bold())
                Text("It's time to make beatiful")
            }
            .padding(.top,34)
            
            
            Spacer()
            NavigationLink {
                SettingsView()
            } label: {
                Image(systemName: "gear")
            }
            .padding(.top,34)
            
            
        }
        .padding()
        .frame(width: getRect().width,height: getRect().height/7)
        .background(.ultraThinMaterial)
        
    }
}

struct HomeTitleRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeTitleRow(user: User(id: "", firstName: "Sarah", lastName: "Smith", email: "sarah.smith@yahoo.com", mobileNumber: 0756734212, password: "12345678",profileImageUrl: "profilepic"))
    }
}
