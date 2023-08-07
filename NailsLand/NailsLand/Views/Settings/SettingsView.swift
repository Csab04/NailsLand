//
//  SettingsView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel:AuthViewModel
    @State var user: User?
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    Section{
                        NavigationLink {
                           AccountView()
                        } label: {
                            Text("Account")
                        }
                        NavigationLink {
                            Text("Notification")
                        } label: {
                            Text("Notification")
                        }

                    } header: {
                        Text("General")
                    }
                    Button {
                        authViewModel.sigOut()
                    } label: {
                        Text("SignOut")
                            .foregroundColor(.red)
                    }
                    
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthViewModel())
    }
}
