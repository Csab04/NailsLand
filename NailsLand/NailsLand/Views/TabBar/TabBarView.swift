//
//  TabBarView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedTab:Tab = .home
    @State var color:Color = .teal
    
    var body: some View {
        ZStack{
            
            Group{
                switch selectedTab {
                case .home:
                    HomeView()
                case .location:
                    LocationView()
                case .shop:
                    ShopView()
                case .profile:
                    AppoimentView()
                       
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            HStack{
                ForEach(tabItems){item in
                    VStack{
                        Button {
                            withAnimation(.spring(response: 0.3,dampingFraction: 0.7)){
                                selectedTab = item.tab
                                color = item.color
                            }
                        } label: {
                            VStack(spacing:0){
                                Image(systemName: item.icon)
                                    .symbolVariant(.fill)
                                    .font(.body.bold())
                                    .frame(width: 34,height: 29)
                                Text(item.text)
                                    .font(.caption2)
                                    .lineLimit(1)
                            }
                            .frame(maxWidth:.infinity)
                        }
                        .foregroundStyle(selectedTab == item.tab ? .primary : .secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
            }
           .padding(.horizontal,8)
           .padding(.top,14)
           .frame(height: 88,alignment: .top)
           .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 34,style: .continuous))
           .background(
            HStack{
                if selectedTab == .profile{Spacer()}
                if selectedTab == .shop{Spacer()}
                if selectedTab == .location{
                    Spacer()
                    Spacer()
                }
                Circle().fill(color).frame(width:80)
                if selectedTab == .home{Spacer()}
                if selectedTab == .shop {
                    Spacer()
                    Spacer()
                }
                if selectedTab == .location{Spacer()}
            }
                .padding(.horizontal,8)
           )
           .overlay(content: {
               HStack{
                   if selectedTab == .profile{Spacer()}
                   if selectedTab == .shop{Spacer()}
                   if selectedTab == .location{
                       Spacer()
                       Spacer()
                   }
                  Rectangle()
                       .fill(color)
                       .frame(width: 28, height: 5)
                       .cornerRadius(3)
                       .frame(width:80)
                       .frame(maxHeight:.infinity,alignment:.top)
                   if selectedTab == .home {Spacer()}
                   if selectedTab == .shop {
                       Spacer()
                       Spacer()
                   }
                   if selectedTab == .location{Spacer()}
               }
                   .padding(.horizontal,8)
           })
           .frame(maxHeight: .infinity,alignment: .bottom)
            .ignoresSafeArea()
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
        TabBarView()
            .preferredColorScheme(.dark)
    }
}
 

