//
//  ServiceCard.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI

struct ServiceCard: View {
    var service:Service
   
    var body: some View {
        HStack(spacing:5){
            VStack(alignment:.leading){
                Image(systemName:service.imageName)
                    .resizable()
                    .frame(width: 75,height: 55)
                
                Text(service.name)
                    .font(.body.bold())
                Text("$\(service.price,format: .number)")
            }
            .frame(width: getRect().width/1.2,height: getRect().height/5)
            .background(Color.gray.opacity(0.5))
            .clipShape(CustomCorner(corner: [.allCorners], radius: 20))
            .shadow(radius: 10,x: -15,y: 5)
            
        }
       
    }
}

struct ServiceCard_Previews: PreviewProvider {
    static var previews: some View {
        ServiceCard(service: Service(imageName: "mouth.fill", name: "Make up", price: 29.00, serviceTab: .makeup))
    }
}
