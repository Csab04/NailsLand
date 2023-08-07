//
//  SuccesAppoimentsAlert.swift
//  NailsLand
//
//  Created by Csaba Otvos on 26.03.2023.
//

import SwiftUI

struct SuccesAppoimentsAlert: View {
    @Binding var show:Bool
    var body: some View {
        VStack(spacing:10){
             Text("Great job!")
                .font(.title.bold())
            Text("Appoiments was succsesful")
                .font(.title3.bold())
                .lineLimit(1)
            Text("Now go to the Appoiments View,and  check your appoiments !")
                .font(.title3.bold())
                .lineLimit(3)
            Spacer()
            Button {
                show.toggle()
                   
            } label: {
                   Text("Ok")
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

struct SuccesAppoimentsAlert_Previews: PreviewProvider {
    static var previews: some View {
        SuccesAppoimentsAlert(show: .constant(false))
    }
}
