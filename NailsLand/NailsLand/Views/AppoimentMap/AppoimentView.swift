//
//  PersonView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI

struct AppoimentView: View {
    @StateObject var appoimentViewModel = AppoimentViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(appoimentViewModel.appoiment,id: \.id){ appoiment in
                        VStack(alignment:.leading){
                            Text(appoiment.date.displayFormatForSectiomHeader)
                                .font(.callout)
                            .foregroundColor(.gray)
                            Text(appoiment.time)
                                .font(.title.bold())
                            Text("Service:\(appoiment.service)")
                            Text("Price:\(appoiment.price,format: .number)")
                            
                        }
                        .frame(maxWidth:.infinity,alignment: .leading)
                        .padding()
                    }
                   
                }
                .listStyle(.inset)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My appoiment")
                }
                
            }
            .onAppear(){
                appoimentViewModel.fetchAppoiment()
            }
        }
    }
}

struct AppoimentView_Previews: PreviewProvider {
    static var previews: some View {
        AppoimentView()
            
    }
}
