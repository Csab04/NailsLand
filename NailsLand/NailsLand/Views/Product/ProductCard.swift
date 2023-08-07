//
//  ProductCard.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI

struct ProductCard: View {
    var product:Product
    var body: some View {
        VStack(spacing:5){
            VStack{
                Image(product.image)
                    .resizable()
            }
            .frame(width: getRect().width/3,height: getRect().height/5)
            .background(.gray)
            .clipShape(CustomCorner(corner: [.allCorners], radius: 20))
            .shadow(radius: 10,x: -15,y: 5)
            Text(product.productName)
                .font(.body.bold())
            Text("$\(product.price,format: .number)")
        }
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: Product(image: "k1", productName: "Neuty family", price: 200.53))
    }
}
