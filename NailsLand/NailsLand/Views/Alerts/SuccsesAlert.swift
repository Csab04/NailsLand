//
//  SuccsesAlert.swift
//  NailsLand
//
//  Created by Csaba Otvos on 16.03.2023.
//

import SwiftUI

struct SuccsesAlert: View {
    var body: some View {
       
        VStack(spacing:10){
             Text("Great job!")
                .font(.title.bold())
            Text("Registration was succsesful")
                .font(.title3.bold())
                .lineLimit(1)
            Text("Now go to the Login Page,and log in your account !")
                .font(.title3.bold())
                .lineLimit(3)
            Spacer()
            NavigationLink {
                LoginView()
            } label: {
                Label("Go back", systemImage: "arrow.left")
                    .foregroundColor(.green)
            }

        }
        .padding()
        .frame(width: getRect().width/1.3,height: getRect().width/1.2)
        .background(.ultraThinMaterial)
        .clipShape(CustomCorner(corner: .allCorners, radius: 20))
        .shadow(radius: 20,x: -5,y: 50)
        .overlay {
            RoundedRectangle(cornerRadius: 20,style: .continuous)
                .stroke(Color.green)
        }
    }
}

struct SuccsesAlert_Previews: PreviewProvider {
    static var previews: some View {
        SuccsesAlert()
        SuccsesAlert()
            .preferredColorScheme(.dark)
    }
}
