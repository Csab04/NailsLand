//
//   CalendarView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 21.03.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
struct AppoinmentsView: View {
    
    @State var show = false
    @State var currentDay : Date = Date()
    @StateObject var appoimentViewModel = AppoimentViewModel()
    @State var appoimentDate:AppoimentDate?
    @State var selectedTime = false
    @State var selectedDate = ""
    @State var removeAccesButton = false
    @Environment(\.dismiss) var dismiss
    @State var user:User?
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    HStack{
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color(Color.purpleBG))
                        }
                        
                        Spacer()
                        Text("Make an appoiment")
                            .foregroundColor(Color(Color.purpleBG))
                        Spacer()
                        Button {
                            withAnimation(.easeInOut(duration: 0.3)){
                                show.toggle()
                            }
                        } label: {
                            Image(systemName: "calendar")
                                .foregroundColor(Color(Color.purpleBG))
                            
                        }
                        
                    }
                    .padding()
                    if show{
                        DatePicker("", selection: $currentDay,displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .tint(Color(Color.purpleBG))
                            .padding()
                        
                    } else {
                        
                        WeekRow()
                    }
                    
                    ScrollView{
                        VStack{
                            ForEach(Array(appoimentViewModel.groupedByMonth()),id: \.key){ day,appoiment in
                                if day == currentDay.displayFormatForSectiomHeader {
                                    ForEach(appoiment){ a in
                                        VStack(spacing:30){
                                            if appoimentViewModel.appoimentDate.isEmpty {
                                               EmptyTimeView()
                                            } else {
                                                AppoimentRow( a, tint: Color(Color.purpleBG), rezerved: appoimentViewModel.succesAppoiments)
                                                
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                    
                                }
                               
                            }
                        }
                        .offset(y: 50)
                    }
                }
                .navigationBarHidden(true)
                .blur(radius: appoimentViewModel.succesAppoiments ? 30 : 0)
                .overlay(content: {
                    LoadingView(show: $appoimentViewModel.isLoading)
                })
                .task {
                    if user != nil {return}
                    await fetchUser()
                    
                }
                
                if appoimentViewModel.succesAppoiments{
                    SuccesAppoimentsAlert(show: $appoimentViewModel.succesAppoiments)
                }
                
                
            }
            .safeAreaInset(edge: .bottom) {
                Button {
                    
                    if let user = user {
                        
                        appoimentViewModel.addAppoiment(date: currentDay, time: selectedDate, name: [user.lastName,user.firstName], email: user.email, mobileNumber: user.mobileNumber, profileImageURl: user.profileImageUrl)
                        
                        
                    }
                    
                   
                    
                } label: {
                    Text("Make Appoiment")
                        .foregroundColor(.white)
                        .frame(width: 250, height: 50)
                        .background(
                            Capsule()
                                .fill(Color(Color.purpleBG))
                        )
                    
                    
                }
                .disabled(selectedDate == "")
                
            }
            
        }
        
    }
    @ViewBuilder
    func WeekRow()-> some View {
        
        VStack{
            
            HStack(spacing: 0) {
                ForEach(Calendar.current.currentWeek){weekday in
                    let status = Calendar.current.isDate(weekday.date, inSameDayAs: currentDay)
                    VStack(spacing:6){
                        Text(weekday.string.prefix(3))
                        Text(weekday.date.toString("dd"))
                    }
                    .foregroundColor(status ? Color(Color.purpleBG) : .gray)
                    .frame(maxWidth:.infinity,alignment: .center)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)){
                            currentDay = weekday.date
                        }
                    }
                    
                }
            }
            
        }
    }
    
    @ViewBuilder
    func AppoimentRow(_ appoiment:AppoimentDate,tint:Color,rezerved:Bool)-> some View{
        
        VStack(spacing: 30) {
            
            Text(appoiment.textTime)
                .foregroundColor(.white)
                .frame(width: 250,height: 50)
                .background(
                    Capsule()
                        .stroke(  selectedDate == appoiment.textTime ? tint : .gray)
                    
                )
                .onTapGesture {
                    selectedDate = appoiment.textTime
                   
                }
            
            
        }
        
        
    }
    
    func fetchUser()async{
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard  let users = try? await Firestore.firestore().collection("User").document(uid).getDocument(as: User.self) else {
            return
        }
        await MainActor.run(body: {
            user = users
        })
    }
    
   
    
}

struct AppoinmentsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppoinmentsView()
            AppoinmentsView()
                .preferredColorScheme(.dark)
        }
    }
}




