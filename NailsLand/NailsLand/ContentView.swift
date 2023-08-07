//
//  ContentView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authViewModel = AuthViewModel()
    var body: some View {
       
            if authViewModel.logStatus == true{
                TabBarView()
            } else {
                LoginView()
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
              ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(AuthViewModel())
    }
}
