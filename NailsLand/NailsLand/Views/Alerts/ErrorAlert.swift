//
//  ErrorAlert.swift
//  NailsLand
//
//  Created by Csaba Otvos on 16.03.2023.
//

import SwiftUI

struct ErrorAlert: View {
    @Binding var errorMessage:String
    @Binding var show:Bool
    var body: some View {
        VStack(spacing:10){
             Text("Error!")
                .font(.title.bold())
           Text(errorMessage)
                .font(.title3.bold())
                .lineLimit(4)
            Spacer()
            Button {
                withAnimation(.spring()){
                    show.toggle()
                }
            } label: {
                Text("Ok")
                    .foregroundColor(.white)
                    .frame(width: 130,height: 30)
                    .background(.red)
                    .cornerRadius(.infinity)
            }


        }
        .padding()
        .frame(width: getRect().width/1.3,height: getRect().width/1.2)
        .background(.ultraThinMaterial)
        .clipShape(CustomCorner(corner: .allCorners, radius: 20))
        .shadow(radius: 20,x: -5,y: 50)
        .overlay {
            RoundedRectangle(cornerRadius: 20,style: .continuous)
                .stroke(Color.red)
        }
    }
}

struct ErrorAlert_Previews: PreviewProvider {
    static var previews: some View {
        ErrorAlert(errorMessage: .constant(""),show: .constant(false))
    }
}
