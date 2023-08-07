//
//  ProductView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 28.03.2023.
//

import SwiftUI

struct ProductView: View {
    var product:Product
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(Color.purpleBG))
                        .padding()
                }
                Spacer()

            }
            Image(product.image)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
           Spacer()
            VStack(alignment:.leading){
                Text(product.productName)
                    .foregroundColor(.white)
                    .font(.title.bold())
                Text("$\(product.price,format: .number)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            .frame(width: getRect().width,height: getRect().height/2)
            .background(.secondary)
            .ignoresSafeArea()
            .safeAreaInset(edge: .bottom) {
                Button {
                    
                } label: {
                    Text("Add to bag")
                        .foregroundColor(.white)
                        .frame(width: 350,height: 50)
                        .background(
                            Capsule()
                                .fill(Color(Color.purpleBG))
                        )
                }

            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: Product(image: "k1", productName: "Neuty family", price: 200.53))
    }
}
