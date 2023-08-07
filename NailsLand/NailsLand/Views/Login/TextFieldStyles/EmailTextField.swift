//
//  EmailTextField.swift
//  NailsLand
//
//  Created by Csaba Otvos on 29.04.2023.
//

import SwiftUI

struct EmailTextField: View {
    @Binding var text: String
    @Binding var imageName: String
    @Binding var placeHolder:String
    var body: some View {
        RoundedRectangle(cornerRadius: 10,style: .continuous)
            .stroke(Color(Color.purpleBG))
            .frame(width: getRect().width/1.2,height: getRect().height/19)
            .overlay {
                TextField(placeHolder, text: $text)
                    .padding(.leading,54)
                    .overlay {
                        HStack{
                            Image(systemName: imageName)
                                .foregroundColor(Color(Color.purpleBG))
                                .padding()
                            Spacer()
                        }
                    }
            }
    }
}

struct EmailTextField_Previews: PreviewProvider {
    static var previews: some View {
        EmailTextField(text: .constant(""), imageName: .constant(""), placeHolder: .constant(""))
       
    }
}
