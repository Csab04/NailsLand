//
//  ServiceView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI

struct ServiceView: View {
    @Environment(\.dismiss) var dismiss
  @State var selectedService = ""
    @State var showSelectedService = false
    @State var selectedServicePrice = 0.0
    @State var startAnimation = false
    @State var appoinment : Appoiment?
    @StateObject var appoimentViewModel = AppoimentViewModel()
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = .purple
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor:UIColor.black], for: .normal)
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        NavigationStack{
            ZStack(alignment:.bottom){
               
                VStack{
                    HStack{
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color(Color.purpleBG))
                        }

                        Spacer()
                        
                        Text("Choos a service")
                            .font(.title2.bold())
                        Spacer()
                    }
                    .padding()
                    
                    ForEach(service,id:\.id){services in
                        
                        VStack{
                            ServiceCards(service: services)
                        }
                    }
                   
                    Spacer()
                    
                  
                    Button {
                        appoimentViewModel.uploadServiceAndPrice(service: selectedService, price: selectedServicePrice)
                    } label: {
                        Text("Continue")
                            .foregroundColor(.white)
                            .frame(width: startAnimation ? 350 : 250 ,height: 50)
                            .background(startAnimation ? .purple : .teal)
                            .cornerRadius(.infinity)
                            .shadow(color: startAnimation ? .purple : .teal,radius: 10,y: 40)
                            .scaleEffect(startAnimation ? 1.1 : 1.0)
                    }
                    .onAppear(){
                        addAnimation()
                    }

                }
                
              
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $appoimentViewModel.showCalendar) {
                AppoinmentsView()
            }
        }
    }
    func addAnimation(){
        guard !startAnimation else{return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            withAnimation(
             Animation
                .easeInOut(duration: 2.0)
                .repeatForever()
            
            ){
                startAnimation.toggle()
            }
        }
    }
    
    @ViewBuilder
    func ServiceCards(service:Service) -> some View{
        VStack{
            HStack(spacing:5){
                VStack(alignment:.leading){
                    Image(systemName:service.imageName)
                        .resizable()
                        .frame(width: 75,height: 55)
                    
                    Text(service.name)
                        .font(.body.bold())
                    Text("$\(service.price,format: .number)")
                }
                .foregroundColor(selectedService == service.name ? .purple : .white)
                .frame(width: getRect().width/1.2,height: getRect().height/5)
                .background(Color.gray.opacity(0.5))
                .clipShape(CustomCorner(corner: [.allCorners], radius: 20))
                .shadow(radius: 10,x: -15,y: 5)
                .onTapGesture {
                    selectedService = service.name
                    selectedServicePrice = service.price
                }
            }
            
        }
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
        ServiceView()
            .preferredColorScheme(.dark)
    }
}


enum ServicePicker:String,CaseIterable{
    case solo = "Solo"
    case package = "Package"
}
