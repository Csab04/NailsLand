//
//  PasswordTextField.swift
//  NailsLand
//
//  Created by Csaba Otvos on 29.04.2023.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var text: String
    @Binding var imageName: String
    @Binding var placeHolder:String
    @State var visibile = false
    var body: some View {
        VStack{
            if visibile {
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
            } else {
                
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .stroke(Color(Color.purpleBG))
                    .frame(width: getRect().width/1.2,height: getRect().height/19)
                    .overlay {
                        SecureField(placeHolder, text: $text)
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
        .overlay {
            HStack{
                Spacer()
                Button {
                    withAnimation(.spring()){
                        visibile.toggle()
                    }
                } label: {
                    Image(systemName: visibile ? "eye.fill" :"eye.slash.fill" )
                        .foregroundColor(Color(Color.purpleBG))
                }

            }
            .padding()
        }
    }
}

struct PasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextField(text: .constant(""), imageName: .constant(""), placeHolder: .constant(""))
    }
}
